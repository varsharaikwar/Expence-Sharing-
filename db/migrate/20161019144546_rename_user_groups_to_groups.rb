class RenameUserGroupsToGroups < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_groups, :groups
  end
end
