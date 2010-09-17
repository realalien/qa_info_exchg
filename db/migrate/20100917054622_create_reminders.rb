class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.string :summary
      t.text :description
      t.datetime :next_notification_send_at

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
