class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.integer :post_id
      t.text :item
      t.timestamps
    end
  end
end
