class AddDailyLimitToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :count
    t.datetime :lasttime
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :count
    t.remove :lasttime
    end
  end
end
