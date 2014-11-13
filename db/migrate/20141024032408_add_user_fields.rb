class AddUserFields < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :boolean
  	add_column :users, :date_of_birth, :datetime
  	add_column :users, :mobile, :string
  end
end
