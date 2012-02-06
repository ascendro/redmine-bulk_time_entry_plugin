class LoggedByUser < ActiveRecord::Base
  unloadable
  belongs_to :time_entry
  belongs_to :logged_by_user, :foreign_key => :logged_by, :class_name => 'User'
end
