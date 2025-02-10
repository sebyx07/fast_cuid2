# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_cuid2

  private
    def set_cuid2
      self.id = FastCuid2.generate
    end
end
