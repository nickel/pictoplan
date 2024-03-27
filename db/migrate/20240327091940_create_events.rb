class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :picto, null: false, foreign_key: true
      t.string :title
      t.integer :day_of_the_week, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
