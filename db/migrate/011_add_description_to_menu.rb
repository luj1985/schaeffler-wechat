class AddDescriptionToMenu < ActiveRecord::Migration
  def self.up
    change_table :menus do |t|
      t.text :description
    end
  end

  def self.down
    change_table :menus do |t|
      t.remove :description
    end
  end
end
