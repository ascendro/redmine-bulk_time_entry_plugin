module BulkTimeEntryPlugin
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        def create_bulk_time_entry(entry)
          member_id = entry.delete("member_id")
          
          time_entry = TimeEntry.new(entry)
          time_entry.hours = nil if time_entry.hours.blank? or time_entry.hours <= 0
          user = nil

          if BulkTimeEntriesController.allowed_project?(entry[:project_id])
            project = Project.find(entry[:project_id])
            
            user = project.members.find_by_id(member_id).user if member_id and BulkTimeEntriesController.allowed_to_log_time_for_others(project)
            
            time_entry.project_id = entry[:project_id] # project_id is protected from mass assignment
          end
          time_entry.user = (user ? user : User.current)
          time_entry.save

          lbu =  LoggedByUser.create!(:time_entry_id => time_entry.id, :logged_by => User.current.id) if user
          
          time_entry
        end
        
      end
      
    end
  end
end
