class AddProductToLottery < ActiveRecord::Migration
  def self.up
    change_table :lotteries do |t|
      t.string :product
    end
  end

  def self.down
    change_table :lotteries do |t|
      t.remove :product
    end
  end
end
