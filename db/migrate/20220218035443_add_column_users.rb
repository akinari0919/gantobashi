class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :offense_win_count, :integer, default: 0 , null: false
  end
end
