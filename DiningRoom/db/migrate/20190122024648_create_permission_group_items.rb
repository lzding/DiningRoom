class CreatePermissionGroupItems < ActiveRecord::Migration[5.2]
  def change
    create_table :permission_group_items do |t|
      t.references :permission, foreign_key: true
      t.references :permission_group, foreign_key: true

      t.timestamps
    end
  end
end
