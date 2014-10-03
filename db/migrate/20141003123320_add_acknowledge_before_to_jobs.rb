class AddAcknowledgeBeforeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :acknowledge_before, :datetime
  end
end
