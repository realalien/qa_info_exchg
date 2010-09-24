class AddPlatformToReleasePackage < ActiveRecord::Migration
  def self.up
	add_column :release_packages,:platform, :string
  end

  def self.down
	drop_column :release_packages, :platform, :string
  end
end
