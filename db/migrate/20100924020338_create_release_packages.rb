class CreateReleasePackages < ActiveRecord::Migration
  def self.up
    create_table :release_packages do |t|
      t.string :filename
      t.string :status
      t.string :location
      t.string :type
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :release_packages
  end
end
