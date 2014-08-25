class AddSizeToImage < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.integer :width
      t.integer :height
    end
    Image.all.each do |record|
      basename = File.basename(record.href)
      path = "public/uploads/#{basename}"
      if File.exists?(path) then
        img = Magick::Image.read(path).first
        record.width = img.columns
        record.height = img.rows
        record.save
      end
    end
  end

  def self.down
    change_table :images do |t|
      t.remove :width
      t.remove :height
    end
  end
end
