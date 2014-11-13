class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :age
      t.string :email
      t.string :mobile
      t.binary :photo

      t.timestamps
    end
  end
end
