# frozen_string_literal: true

# ext/fast_cuid2/extconf.rb
require 'mkmf'

# Add optimization flags
$CFLAGS << ' -O3 -Wall -Wextra'

# Check for required headers
have_header('ruby.h')
have_header('ruby/encoding.h')

extension_name = 'fast_cuid2/fast_cuid2'
dir_config(extension_name)

create_makefile(extension_name)
