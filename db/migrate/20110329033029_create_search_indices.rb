class CreateSearchIndices < ActiveRecord::Migration
  def self.up
    create_table :search_indices do |t|
      t.integer :resource_id
      t.string :name
      t.string :resource_type

      t.timestamps
    end
  end

  def self.down
    drop_table :search_indices
  end
end
