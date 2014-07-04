class AddTypeToAutoReply < ActiveRecord::Migration
  def self.up
    change_table :auto_replies do |t|
      t.string :rtype
    end
  end

  def self.down
    change_table :auto_replies do |t|
      t.remove :rtype
    end
  end
end
