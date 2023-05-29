class ChangeDescriptionToRichTextInProjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :description
    add_column :projects, :description, :rich_text
  end
end
