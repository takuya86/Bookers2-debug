class AddRateToBook < ActiveRecord::Migration[6.1]
  def up
    add_column :books, :star, :string
  end
  
  def down
    remove_column :books, :star, :string
  end
end
