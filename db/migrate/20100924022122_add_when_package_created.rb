class AddWhenPackageCreated < ActiveRecord::Migration
  def self.up
	add_column :release_packages, :when_package_created, :datetime
  end

  def self.down
	drop_column :release_packages, :when_package_created, :datetime
  end
end
