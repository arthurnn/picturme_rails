class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.string :image

      t.timestamps
    end
  end
end
