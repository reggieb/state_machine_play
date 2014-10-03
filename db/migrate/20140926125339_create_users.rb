class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email

      t.timestamps
    end
    
    add_column :jobs, :creator_id, :integer
  end
end
