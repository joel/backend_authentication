# frozen_string_literal: true

class CreateDeliverables < ActiveRecord::Migration[7.0]
  def change
    create_table :deliverables, id: false do |t|
      t.string :id, index: { unique: true }, primary_key: true
      t.string :name, null: false
      t.string :project_id, null: false
      t.foreign_key :projects, column: :project_id, primary_key: "id", on_delete: :cascade
      t.datetime :due_at
      t.integer :status, default: 0, null: false
      t.boolean :active, default: true, null: false
      t.json :metadata, default: {}, null: false

      t.timestamps
    end
  end
end
