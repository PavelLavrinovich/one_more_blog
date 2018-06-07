class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.integer :value
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
