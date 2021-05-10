class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.integer :end_user_id
      t.string :title
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end
