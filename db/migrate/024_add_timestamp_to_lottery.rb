class AddTimestampToLottery < ActiveRecord::Migration
  def self.up
    change_table :lotteries do |t|
      t.datetime :exchange_time
    end
  end

  def self.down
    change_table :lotteries do |t|
      t.remove :exchange_time
    end
  end
end
