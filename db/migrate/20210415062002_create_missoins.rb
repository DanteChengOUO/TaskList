class CreateMissoins < ActiveRecord::Migration[6.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.integer :sort
      t.string :status
      t.text :context
      t.string :tag
      t.time :start
      t.time :end

      t.timestamps
    end
  end
end
