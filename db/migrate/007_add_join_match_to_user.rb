class AddJoinMatchToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :join_match
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :join_match
    end
  end
end
