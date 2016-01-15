class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.text :description
      t.string :country
      t.string :city

      t.timestamps null: false
    end
  end
end
