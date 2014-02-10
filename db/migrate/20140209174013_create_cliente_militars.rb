class CreateClienteMilitars < ActiveRecord::Migration
  def change
    create_table :cliente_militars do |t|
      t.string :relacion
      t.references :cliente, index: true
      t.references :militar, index: true

      t.timestamps
    end
  end
end
