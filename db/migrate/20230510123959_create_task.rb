class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :priority
      
      t.references :member, foreign_key: { to_table: :users }
      t.references :creator, foreign_key: { to_table: :users }

      t.references :project, foreign_key:true

      t.timestamps
    end
  end
end
