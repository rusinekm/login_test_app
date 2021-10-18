# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :handle
      t.string :password
      t.string :salt
      t.integer :failed_login_attempts, default: 0, null: false
      t.timestamps
    end
  end
end
