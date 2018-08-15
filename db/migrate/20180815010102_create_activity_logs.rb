class CreateActivityLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_logs do |t|
      t.references :loggable, null: false, polymorphic: true
      t.text :changes_text, null: false

      t.datetime :created_at, null: false
    end
  end
end
