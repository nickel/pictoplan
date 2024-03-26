class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
