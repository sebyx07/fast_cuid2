# frozen_string_literal: true

require 'rails_helper'

require 'set'

RSpec.describe FastCuid2 do
  describe '.generate' do
    let(:cuid) { FastCuid2.generate }

    it 'generates valid CUID2s' do
      expect(cuid).to match(/^[a-z][0-9a-hjkmnp-tv-z]{23}$/)
    end

    it 'generates unique IDs' do
      ids = Set.new
      100.times { ids.add(FastCuid2.generate) }
      expect(ids.size).to eq(100)
    end

    it 'is thread safe' do
      ids = Set.new
      threads = 5.times.map do
        Thread.new { 20.times { ids.add(FastCuid2.generate) } }
      end
      threads.each(&:join)

      expect(ids.size).to eq(100)
    end
  end
end
