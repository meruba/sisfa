class CreateClienteMilitars < ActiveRecord::Migration
  def change
    create_table :cliente_militars do |t|
      t.references :cliente, index: true
      t.references :militar, index: true
      t.string :relacion

      t.timestamps
    end
  end
end
