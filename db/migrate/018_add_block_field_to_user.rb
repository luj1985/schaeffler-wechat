class AddBlockFieldToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :blocked
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :blocked
    end
  end
end
