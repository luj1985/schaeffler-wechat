class AddImageToArticle < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.string :image
    end
  end

  def self.down
    change_table :articles do |t|
      t.remove :image
    end
  end
end
