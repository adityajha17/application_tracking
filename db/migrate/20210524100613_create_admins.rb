class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.integer :mobile, null: false, default: ""
      t.integer :otp

      t.timestamps
    end
  end
end
