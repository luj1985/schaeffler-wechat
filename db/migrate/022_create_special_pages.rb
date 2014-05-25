class CreateSpecialPages < ActiveRecord::Migration
  def self.up
    create_table :special_pages do |t|
      t.string :title
      t.string :href
      t.timestamps
    end
  end

  def self.down
    drop_table :special_pages
  end
end
