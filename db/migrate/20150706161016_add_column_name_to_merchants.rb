class AddColumnNameToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :name, :string
  end
end
