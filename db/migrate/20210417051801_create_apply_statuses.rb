class CreateApplyStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :apply_statuses do |t|
      t.string :jid
      t.string :uid
      t.string :job_title
      t.string :u_name
      t.boolean :status

      t.timestamps
    end
  end
end
