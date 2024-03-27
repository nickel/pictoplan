class CreatePictos < ActiveRecord::Migration[7.1]
  def change
    create_table :pictos do |t|
      t.string :external_source
      t.string :external_id

      t.string :keyword

      t.jsonb :data

      t.boolean :enabled, default: true

      t.timestamps
    end

    add_index :pictos, [:external_source, :external_id], unique: true
  end
end
