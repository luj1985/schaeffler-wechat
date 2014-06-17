class CreateAutoReplies < ActiveRecord::Migration
  def self.up
    create_table :auto_replies do |t|
      t.string :keyword
      t.text :reply
      t.timestamps
    end
  end

  def self.down
    drop_table :auto_replies
  end
end
