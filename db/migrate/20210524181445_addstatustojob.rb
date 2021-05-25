class Addstatustojob < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :status, :boolean
  end
end
