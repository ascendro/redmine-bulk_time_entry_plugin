class CreateLoggedByUsers < ActiveRecord::Migration
  def self.up
    create_table :logged_by_users do |t|
      t.column :time_entry_id, :integer
      t.column :logged_by, :integer
    end
  end

  def self.down
    drop_table :logged_by_users
  end
end
