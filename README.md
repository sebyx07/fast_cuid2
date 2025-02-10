# FastCuid2 🚀

A high-performance CUID2 (Collision-resistant Unique ID) generator for Ruby, implemented in C for maximum speed while maintaining cryptographic security.

## Why FastCuid2? ✨

FastCuid2 combines the best of all worlds:
- 🚄 Blazing fast: C-optimized implementation that's 242x faster than pure Ruby
- 🔒 Cryptographically secure: Based on OpenSSL's CSPRNG
- 📱 Perfect for modern apps: URL-safe and short (24 chars)
- 🔄 Built for distributed databases: No coordination needed between servers
- ⏰ Roughly time-sortable: Natural chronological ordering without exactness constraints
- 🎯 Zero collisions: Mathematically designed to avoid ID conflicts
- 🌐 Human-friendly: Easy to read, copy, and share in URLs

## What is CUID2? 🤔

[CUID2](https://github.com/paralleldrive/cuid2) is the next generation of collision-resistant ids, designed to be:
- 🔒 Secure: Uses cryptographically secure random numbers
- 📏 Compact: Just 24 characters (vs UUID's 36)
- 🔗 URL-safe: Perfect for web applications
- ⏰ Time-ordered: Built-in chronological sorting
- 🎯 Distributed-ready: Safe for multiple servers and processes

## Perfect For 🎯

- 🌐 Modern web applications
- 📱 REST APIs and GraphQL
- 🔄 Distributed systems
- 📂 Content management systems
- 🔗 URL-friendly resources
- 🎮 Real-time applications
- 📈 High-scale systems

## Installation 💿

Add this line to your application's Gemfile:

```ruby
gem 'fast_cuid2'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install fast_cuid2
```

## Usage 🛠️

### Basic Usage 💡

```ruby
require 'fast_cuid2'

# Generate a new CUID2
id = FastCuid2.generate
puts id  # => "k2zt4qxvz5..."

# Use as a before_create callback in your models
class User < ApplicationRecord
  before_create :set_cuid2

  private
    def set_cuid2
      self.id = FastCuid2.generate
    end
end
```

### Database Migrations 🗄️

Example migration for creating a new table with CUID2:

```ruby
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true, null: false, limit: 24
      t.timestamps
    end
  end
end
```

Adding a CUID2 column to an existing table:

```ruby
class AddReferenceToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :reference_id, :string, limit: 24
    add_index :posts, :reference_id, unique: true
  end
end
```

## Features in Detail 🌟

### Security 🔒
- Based on OpenSSL's CSPRNG
- Cryptographically secure random numbers
- Designed to prevent ID guessing

### Performance ⚡
- Implemented in C for maximum speed
- Minimal memory allocations
- Thread-safe implementation
- Optimal for high-throughput systems

### Time-Ordering and Database Benefits ⏰
- Natural chronological sorting (rough ordering)
- Perfect for distributed databases:
    - No central coordination needed
    - Works across multiple data centers
    - Scale horizontally without conflicts
- Great for high-write scenarios:
    - No sequence/auto-increment bottlenecks
    - Efficient index distribution
    - Better write distribution across shards
- Ideal for activity feeds and content management
- Simple historical data organization

### URL Safety 🔗
- No special characters
- Safe for URLs without encoding
- Easy to copy and paste
- Human-readable format

## CUID2 Format 📋

Each CUID2 is a 24-character string that:
- 📝 Always starts with a letter
- ⌨️ Uses only lowercase letters and numbers (excluding i, l, o, u)
- 🕒 Includes a time component for sorting
- 🔐 Has cryptographically secure random data

## Performance ⚡

FastCuid2 is blazing fast! Here's how it compares:

```
Detailed IPS comparison:
SecureRandom:  2,268,560.6 i/s
   FastCuid2:  1,265,180.7 i/s - 1.79x slower
       Cuid2:      5,141.8 i/s - 441.20x slower
```

Testing Environment:
- Ruby 3.4.1 with YJIT and PRISM
- Linux x86_64
- All implementations maintain cryptographic security

### Key Benefits 🎯

1. FastCuid2 advantages:
    - Unique, roughly time-sortable IDs at high speed
    - Perfect for distributed databases:
        - No coordination between servers
        - Works across regions and data centers
        - Efficient for sharding and scaling
    - Production-ready and battle-tested
    - Ideal for modern distributed applications

2. Compared to alternatives:
    - More features than SecureRandom
    - Much faster than pure Ruby CUID2
    - Shorter than UUIDs
    - More URL-friendly than all alternatives

## Development 👩‍💻

After checking out the repo, run:

```bash
$ bundle install
$ rake compile  # Builds the C extension
$ rake spec    # Runs the tests
```

## Contributing 🤝

Bug reports and pull requests are welcome on GitHub at https://github.com/sebyx07/fast_cuid2. This project is intended to be a safe, welcoming space for collaboration.

## License 📜

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct 🤝

Everyone interacting in the FastCuid2 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sebyx07/fast_cuid2/blob/master/CODE_OF_CONDUCT.md).