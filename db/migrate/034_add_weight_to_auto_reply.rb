class AddWeightToAutoReply < ActiveRecord::Migration
  def self.up
    change_table :auto_replies do |t|
      t.integer :weight
    end
  end

  def self.down
    change_table :auto_replies do |t|
      t.remove :weight
    end
  end
end
