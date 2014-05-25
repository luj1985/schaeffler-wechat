class AddM2MToPage < ActiveRecord::Migration
  def self.up
  	create_table :page_relations do |t|
      t.belongs_to :page
      t.belongs_to :menu
      t.timestamps
    end
  end

  def self.down
  end
end