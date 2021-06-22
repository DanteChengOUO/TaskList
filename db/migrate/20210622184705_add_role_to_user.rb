class AddRoleToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :role, :integer, null: false, default: 0

    if User.find_by(role: :admin).blank?
      admin = User.first_or_create!(name:'admin',
                                    email: 'admin@task.list',
                                    password: '123123',
                                    password_confirmation: '123123')
      admin.update(role: :admin)
    end
  end

  def down
    remove_column :users, :role
  end
end
