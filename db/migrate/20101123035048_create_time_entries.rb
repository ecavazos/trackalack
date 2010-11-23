class CreateTimeEntries < ActiveRecord::Migration
  def self.up
    create_table :time_entries do |t|
      t.date :date
      t.integer :duration
      t.text :description
      t.references :project
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :time_entries
  end
end
