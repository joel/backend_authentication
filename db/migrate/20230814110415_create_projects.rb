# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: false do |t|
      t.string :id, index: { unique: true }, primary_key: true
      t.string :name
      t.string :user_id, null: false
      t.foreign_key :users, column: :user_id, primary_key: "id", on_delete: :cascade

      t.timestamps
    end
  end
end
