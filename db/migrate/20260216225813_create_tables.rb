class CreateTables < ActiveRecord::Migration[7.2]
  def change
    create_table :customers, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name, null: false
      t.string :document_number, null: false, index: { unique: true }
      t.string :email
      t.string :phone
      t.timestamps
    end

    create_table :vehicles, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :customer, type: :uuid, null: false, foreign_key: true
      t.string :license_plate, null: false, index: { unique: true }
      t.string :brand
      t.string :model
      t.integer :year
      t.timestamps
    end
  end
end
