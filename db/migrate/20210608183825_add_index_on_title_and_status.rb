class AddIndexOnTitleAndStatus < ActiveRecord::Migration[6.0]
  def change
    add_index :missions, [:title, :status]
  end
end
