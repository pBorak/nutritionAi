class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :sex,                         null: false
      t.integer :activity_level,             null: false
      t.float :calorie_spread_ratio,         null: false
      t.float :protein_ratio,                null: false
      t.float :fat_ratio,                    null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
