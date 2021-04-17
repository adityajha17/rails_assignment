class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.bigint :phone
      t.integer :otp
      t.timestamps
    end
  end
end
