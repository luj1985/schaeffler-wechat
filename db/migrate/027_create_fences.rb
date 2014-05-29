class CreateFences < ActiveRecord::Migration
  def self.up
    create_table :fences do |t|
      t.string :openid
      t.datetime :activetime
      t.integer :success
      t.integer :fail
      t.timestamps
    end
  end

  def self.down
    drop_table :fences
  end
end
