class AddAbstractToPage < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.text :abstract
    end
  end

  def self.down
    change_table :pages do |t|
      t.remove :abstract
    end
  end
end
