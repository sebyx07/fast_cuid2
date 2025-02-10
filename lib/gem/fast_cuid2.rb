# frozen_string_literal: true

Dir.glob(File.join(File.dirname(__FILE__), 'fast_cuid2', '**', '*.rb')).each do |file|
  require file
end

begin
  require 'fast_cuid2/fast_cuid2'
rescue LoadError
  puts 'Error loading fast_cuid2 extension'
end

module FastCuid2
  class Error < StandardError; end
end
