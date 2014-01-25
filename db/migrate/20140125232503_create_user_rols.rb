class CreateUserRols < ActiveRecord::Migration
  def change
    create_table :user_rols do |t|
      t.references :user, index: true
      t.references :rol, index: true

      t.timestamps
    end
  end
end
