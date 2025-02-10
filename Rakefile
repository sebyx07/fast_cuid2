# frozen_string_literal: true

require_relative 'config/application'
require 'rake/extensiontask'
require 'rake/testtask'

# Load Rails tasks
Rails.application.load_tasks

# Add C extension compilation task
Rake::ExtensionTask.new('fast_cuid2') do |ext|
  ext.lib_dir = 'lib/fast_cuid2'
  ext.ext_dir = 'ext/fast_cuid2'
end

task build: :compile
