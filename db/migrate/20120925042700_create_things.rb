class CreateThings < ActiveRecord::Migration
  def up
  	create_table :things do |t|
  		t.string :thing
  		t.text :definition

  		t.timestamps

  	end
  end

  def down
  	drop_table :things
  end
end
