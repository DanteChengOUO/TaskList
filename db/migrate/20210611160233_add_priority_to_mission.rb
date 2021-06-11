class AddPriorityToMission < ActiveRecord::Migration[6.0]
  def change
    add_column :missions, :priority, :integer, null: false, default: 0
  end
end
