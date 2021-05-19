class CreateMissions < ActiveRecord::Migration[6.0]
  def change
    create_table :missions do |t|
      t.string :title, null: false, limit: 50 
      t.text :content, null: false
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
