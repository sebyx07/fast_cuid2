# frozen_string_literal: true

require_relative 'lib/gem/fast_cuid2/version'

Gem::Specification.new do |spec|
  spec.name = 'fast_cuid2'
  spec.version = FastCuid2::VERSION
  spec.authors = ['sebi']
  spec.email = ['gore.sebyx@yahoo.com']

  spec.summary = 'Fast CUID2 generator with C extension'
  spec.description = 'High-performance CUID2 (Collision-resistant Unique ID) generator ' \
    'implemented in C for maximum speed while maintaining cryptographic security.'
  spec.homepage = 'https://github.com/sebyx07/fast_cuid2'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Include C extension
  spec.extensions = ['ext/fast_cuid2/extconf.rb']

  # Include files
  spec.files = Dir.glob('{lib,ext}/**/*') + ['README.md']

  spec.require_paths = ['lib']

  # Development dependencies
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rake-compiler', '~> 1.2'
end
