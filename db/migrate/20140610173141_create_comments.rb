class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.timestamps

      t.belongs_to :user
      t.belongs_to :post, index: true
    end
  end
end
