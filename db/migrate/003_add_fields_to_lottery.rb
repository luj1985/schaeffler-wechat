class AddFieldsToLottery < ActiveRecord::Migration
  def self.up
    change_table :lotteries do |t|
      t.string :serial
    t.string :crypted_serial
    end
  end

  def self.down
    change_table :lotteries do |t|
      t.remove :serial
    t.remove :crypted_serial
    end
  end
end
