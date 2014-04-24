class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string :name
      t.string :text
      t.string :link
      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
