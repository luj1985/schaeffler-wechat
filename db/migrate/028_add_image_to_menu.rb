class AddImageToMenu < ActiveRecord::Migration
  def self.up
    change_table :menus do |t|
      t.string :image
    end
  end

  def self.down
    change_table :menus do |t|
      t.remove :image
    end
  end
end
