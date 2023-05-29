class AddUniquenessConstraintToProjectMembers < ActiveRecord::Migration[7.0]
  def change
    add_index :project_members, [:member_id, :project_id], unique:true
  end
end
