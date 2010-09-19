class CreateAdvices < ActiveRecord::Migration
  def self.up
    create_table :advices do |t|
      t.text :advice
      t.string :name
      t.string :email
      t.text :other_contact_info

      t.timestamps
    end
  end

  def self.down
    drop_table :advices
  end
end
