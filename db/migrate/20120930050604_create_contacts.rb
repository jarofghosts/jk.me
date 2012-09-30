class CreateContacts < ActiveRecord::Migration
  def up
  	create_table :messages do |t|
  		t.string :name
      t.string :respond
  		t.text :message

  		t.timestamps

  	end
  end

  def down
  	drop_table :messages
  end
end