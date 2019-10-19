class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_coloumn :users, :admin, :boolean, default: false, null: false
  end
end
