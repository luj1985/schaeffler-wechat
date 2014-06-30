class UpdateAutoReply < ActiveRecord::Migration
  def self.up
    change_table :auto_replies do |t|
      t.string :title
      t.string :pic_url
      t.string :url
      t.string :event
    end
    rename_column :auto_replies, :keyword, :param
    rename_column :auto_replies, :reply, :description
  end

  def self.down
    change_table :auto_replies do |t|
      t.string :title
      t.string :pic_url
      t.string :url
      t.string :event
      t.remove :event
    end
    rename_column :auto_replies, :param, :keyword
    rename_column :auto_replies, :description, :reply
  end
end
