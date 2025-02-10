# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ID Generation Implementation Comparison' do
  context 'when comparing FastCuid2, Cuid2, and SecureRandom' do
    let(:iterations) { 10_000 }

    it 'benchmarks single-thread performance' do
      puts "\nSingle thread performance (#{iterations} iterations):"
      Benchmark.bm(20) do |x|
        x.report('FastCuid2:') { iterations.times { FastCuid2.generate } }
        x.report('Cuid2:') { iterations.times { Cuid2.generate } }
        x.report('SecureRandom:') { iterations.times { SecureRandom.hex(12) } }
      end
    end

    it 'compares iterations per second' do
      puts "\nDetailed IPS comparison:"
      Benchmark.ips do |x|
        x.config(time: 2, warmup: 1)
        x.report('FastCuid2') { FastCuid2.generate }
        x.report('Cuid2') { Cuid2.generate }
        x.report('SecureRandom') { SecureRandom.hex(12) }
        x.compare!
      end
    end
  end
end
