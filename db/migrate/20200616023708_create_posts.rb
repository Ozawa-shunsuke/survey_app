class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :description
      t.references :user, foreign_key: true
      t.text :title
      t.text :choice_1
      t.text :choice_2

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
