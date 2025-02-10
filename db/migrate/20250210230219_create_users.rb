# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true, null: false, limit: 24
      t.string :name

      t.timestamps
    end
  end
end
