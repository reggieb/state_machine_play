class AddAcknowledgerIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :acknowledger_id, :integer
  end
end
