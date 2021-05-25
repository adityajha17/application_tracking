class Addcolumntoapplyjobs < ActiveRecord::Migration[6.1]
  def change
    # add_column  :apply_jobs, :job_id, :integer
    # add_column :apply_jobs, :user_id, :integer
    add_column :apply_jobs, :job_title, :string
    add_column :apply_jobs, :user_name, :string
  end
end
