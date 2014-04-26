class AddHrefFiledToImage < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.string :href
    end
  end

  def self.down
    change_table :images do |t|
      t.remove :href
    end
  end
end
