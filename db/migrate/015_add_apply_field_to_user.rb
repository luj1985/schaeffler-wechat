class AddApplyFieldToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :apply_attemped
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :apply_attemped
    end
  end
end
