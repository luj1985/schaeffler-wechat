class AddChargeTelToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :chargetel
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :chargetel
    end
  end
end
