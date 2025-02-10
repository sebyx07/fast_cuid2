#include <ruby.h>
#include <time.h>
#include <openssl/rand.h>
#include <string.h>

/* Constants for CUID2 generation */
#define CUID2_LENGTH 24
#define CUID2_BUFFER_SIZE (CUID2_LENGTH + 1)
#define TIMESTAMP_LENGTH 6
#define RANDOM_BYTES_LENGTH 12
#define BASE32_CHARS_LENGTH 32
#define TIMESTAMP_BITS 5
#define RANDOM_CHUNK_SIZE 2
#define BASE32_CHARS_PER_CHUNK 3

/* Base32 alphabet excluding i, l, o, u for better readability */
static const char BASE32_CHARS[] = "0123456789abcdefghjkmnpqrstvwxyz";

static VALUE rb_mFastCuid2;

/**
 * Encodes an integer into base32 representation.
 * @param num The number to encode
 * @param output The buffer to write to
 * @param length The number of characters to write
 */
static void encode_base32(uint64_t num, char *output, int length) {
    for (int i = length - 1; i >= 0; i--) {
        output[i] = BASE32_CHARS[num & 0x1f];
        num >>= TIMESTAMP_BITS;
    }
}

/**
 * Generates cryptographically secure random bytes.
 * @param buf Buffer to store random bytes
 * @param length Number of random bytes to generate
 * @raises RuntimeError if random byte generation fails
 */
static void generate_random_bytes(unsigned char *buf, int length) {
    if (RAND_bytes(buf, length) != 1) {
        rb_raise(rb_eRuntimeError, "Failed to generate secure random bytes");
    }
}

/**
 * Ensures the first character of the CUID2 is a letter.
 * @param cuid The CUID2 string to modify
 */
static void ensure_first_char_is_letter(char *cuid) {
    if (cuid[0] >= '0' && cuid[0] <= '9') {
        int offset = 10 + (cuid[0] - '0'); // Map digit to letter range
        cuid[0] = BASE32_CHARS[offset];
    }
}

/**
 * Generates a CUID2 (Collision-resistant Unique IDentifier).
 * Format: <6 chars timestamp><18 chars random>
 * @return [String] A 24-character CUID2
 * @raise [RuntimeError] If generation fails
 */
static VALUE rb_generate_cuid2(VALUE self) {
    char cuid[CUID2_BUFFER_SIZE] = {0};
    struct timespec ts;
    unsigned char random_bytes[RANDOM_BYTES_LENGTH];

    // Get current timestamp in milliseconds
    if (clock_gettime(CLOCK_REALTIME, &ts) != 0) {
        rb_raise(rb_eRuntimeError, "Failed to get system time");
    }
    uint64_t timestamp = (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;

    // Generate random bytes
    generate_random_bytes(random_bytes, RANDOM_BYTES_LENGTH);

    // Encode timestamp (first 6 chars)
    encode_base32(timestamp, cuid, TIMESTAMP_LENGTH);

    // Fill remaining 18 chars with random data
    // Process 2 bytes at a time to generate 3 base32 chars
    for (int i = 0; i < RANDOM_BYTES_LENGTH; i += RANDOM_CHUNK_SIZE) {
        uint32_t rand_chunk =
            ((uint32_t)random_bytes[i] << 8) |
            ((uint32_t)random_bytes[i + 1]);
        encode_base32(rand_chunk, cuid + TIMESTAMP_LENGTH + (i / RANDOM_CHUNK_SIZE) * BASE32_CHARS_PER_CHUNK, BASE32_CHARS_PER_CHUNK);
    }

    ensure_first_char_is_letter(cuid);

    return rb_str_new2(cuid);
}

/**
 * Validates a CUID2 string.
 * @param str [String] The string to validate
 * @return [Boolean] true if valid CUID2, false otherwise
 */
static VALUE rb_validate_cuid2(VALUE self, VALUE str) {
    Check_Type(str, T_STRING);

    if (RSTRING_LEN(str) != CUID2_LENGTH) return Qfalse;

    const char *cuid = StringValuePtr(str);
    for (int i = 0; i < CUID2_LENGTH; i++) {
        if (!strchr(BASE32_CHARS, cuid[i])) return Qfalse;
    }

    // First character must be a letter
    if (strchr("0123456789", cuid[0])) return Qfalse;

    return Qtrue;
}

void Init_fast_cuid2(void) {
    rb_mFastCuid2 = rb_define_module("FastCuid2");
    rb_define_singleton_method(rb_mFastCuid2, "generate", rb_generate_cuid2, 0);
    rb_define_singleton_method(rb_mFastCuid2, "valid?", rb_validate_cuid2, 1);
}