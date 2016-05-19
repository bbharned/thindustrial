class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
		t.string :firstname
		t.string :lastname
		t.string :company
		t.string :email
		t.string :phone
		t.string :street
		t.string :city
		t.string :state
		t.integer :zipcode
		t.timestamps
    end
  end
end
