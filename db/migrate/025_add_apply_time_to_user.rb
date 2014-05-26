class AddApplyTimeToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.datetime :apply_time
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :apply_time
    end
  end
end
