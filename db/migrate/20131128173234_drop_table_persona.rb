class DropTablePersona < ActiveRecord::Migration
  def up
    drop_table :personas
  end
end
