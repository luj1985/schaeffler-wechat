class AddImageOffsetToArticle < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.string :offset
    end
  end

  def self.down
    change_table :articles do |t|
      t.remove :offset
    end
  end
end
