class AddRegionToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :province
    t.string :city
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :province
    t.remove :city
    end
  end
end
