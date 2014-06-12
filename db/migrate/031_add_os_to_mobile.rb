class AddOsToMobile < ActiveRecord::Migration
  def self.up
    change_table :mobiles do |t|
      t.string :os
    end
  end

  def self.down
    change_table :mobiles do |t|
      t.remove :os
    end
  end
end
