class CreateResultPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :result_posts do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :choice_id, null: false
      t.timestamps
    end
  end
end
