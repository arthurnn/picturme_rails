class CreatePixels < ActiveRecord::Migration
  def change
    create_table :pixels do |t|
      t.integer :r
      t.integer :g
      t.integer :b
      t.string :image1
      t.integer :qr
      t.integer :qg
      t.integer :qb
      t.string :url
    end
  end
end
