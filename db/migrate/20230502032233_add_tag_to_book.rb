class AddTagToBook < ActiveRecord::Migration[6.1]
  def up
    add_column :books, :tag, :string
  end
  
  def down
    remove_column :books, :tag, :string
  end
end
