class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.references :ip_address, foreign_key: true
      t.decimal :average_mark, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
