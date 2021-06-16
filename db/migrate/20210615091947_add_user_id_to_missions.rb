class AddUserIdToMissions < ActiveRecord::Migration[6.0]
  def up
    add_column :missions, :user_id, :bigint
    add_index :missions, :user_id

    admin = User.first_or_create!(name:'admin', email: 'admin@task.list')
    Mission.update(user: admin)

    change_column_null :missions, :user_id, false
  end

  def down
    remove_index :missions, :user_id
    remove_column :missions, :user_id
  end
end
