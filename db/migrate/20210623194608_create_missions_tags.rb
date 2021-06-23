class CreateMissionsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :missions_tags do |t|
      t.integer :tag_id
      t.integer :mission_id

      t.timestamps
    end
  end
end
