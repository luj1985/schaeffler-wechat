class AddAbstractFieldToArticle < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.text :abstract
    end
  end

  def self.down
    change_table :articles do |t|
      t.remove :abstract
    end
  end
end
