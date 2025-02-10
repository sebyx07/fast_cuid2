# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a new user' do
    user = User.create(name: 'John Doe')
    expect(user.name).to eq('John Doe')

    expect(user.id).to be_a(String)
  end
end
