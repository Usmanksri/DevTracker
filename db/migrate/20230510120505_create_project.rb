class CreateProject < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|

      t.string :name
      t.text :description
      t.references :creator, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
