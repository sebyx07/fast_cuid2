# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CUID2 Implementation Comparison' do
  context 'when comparing FastCuid2 and Cuid2' do
    let(:iterations) { 10_000 }
    let(:thread_count) { 2 }
    let(:ids_per_thread) { 5_000 }

    it 'benchmarks single-thread performance' do
      puts "\nSingle thread performance (#{iterations} iterations):"
      Benchmark.bm(20) do |x|
        x.report('FastCuid2:') { iterations.times { FastCuid2.generate } }
        x.report('Cuid2:') { iterations.times { Cuid2.generate } }
      end
    end

    it 'compares iterations per second' do
      puts "\nDetailed IPS comparison:"
      Benchmark.ips do |x|
        x.config(time: 2, warmup: 1)
        x.report('FastCuid2') { FastCuid2.generate }
        x.report('Cuid2') { Cuid2.generate }
        x.compare!
      end
    end
  end
end
