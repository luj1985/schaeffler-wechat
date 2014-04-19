class CreateLotteries < ActiveRecord::Migration
  def self.up
    create_table :lotteries do |t|
      t.string :name
      t.string :tel
      t.timestamps
    end
  end

  def self.down
    drop_table :lotteries
  end
end
