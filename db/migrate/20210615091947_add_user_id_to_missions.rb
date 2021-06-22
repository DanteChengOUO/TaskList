class AddUserIdToMissions < ActiveRecord::Migration[6.0]
  def up
    add_column :missions, :user_id, :bigint
    add_index :missions, :user_id

    if Mission.all.present?
      user = User.first_or_create!(name:'user',
                                   email: 'user@task.list',
                                   password: '123123',
                                   password_confirmation: '123123')
      Mission.update(user: user)
    end

    change_column_null :missions, :user_id, false
  end

  def down
    remove_index :missions, :user_id
    remove_column :missions, :user_id
  end
end
