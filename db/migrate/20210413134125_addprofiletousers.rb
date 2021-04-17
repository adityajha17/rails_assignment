class Addprofiletousers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :location, :text
    add_column :users, :age, :integer
    add_column :users, :phone, :bigint
  end
end
