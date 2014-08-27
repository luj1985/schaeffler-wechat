class AddImageOffsetToMenu < ActiveRecord::Migration
  def self.up
    change_table :menus do |t|
      t.string :offset
    end
  end

  def self.down
    change_table :menus do |t|
      t.remove :offset
    end
  end
end
