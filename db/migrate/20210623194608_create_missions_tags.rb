class CreateMissionsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :missions_tags do |t|
      t.integer :tag_id, null: false
      t.integer :mission_id, null: false

      t.timestamps
    end
  end
end
