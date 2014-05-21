class AddMenuArticleM2M < ActiveRecord::Migration
  def self.up
  	create_table :relations do |t|
  	  t.belongs_to :article
  	  t.belongs_to :menu
  	  t.timestamps
  	end
  end

  def self.down
  	drop_table :relations
  end
end
