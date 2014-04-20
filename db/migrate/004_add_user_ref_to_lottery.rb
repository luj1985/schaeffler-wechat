class AddUserRefToLottery < ActiveRecord::Migration
  def self.up
    change_table :lotteries do |t|
      t.belongs_to :user, :inverse_of => :lotteries
    end
  end

  def self.down
    change_table :lotteries do |t|
      t.remove :user
    end
  end
end
