class MakeMe < ActiveRecord::Migration
  def up
  	create_table :ghostjars do |t|
  		t.string :password
  	end
  end

  def down
  	drop_table :ghostjars
  end
end
