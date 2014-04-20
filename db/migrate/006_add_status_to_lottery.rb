class AddStatusToLottery < ActiveRecord::Migration
  def self.up
    change_table :lotteries do |t|
      t.string :status
    end
  end

  def self.down
    change_table :lotteries do |t|
      t.remove :status
    end
  end
end
