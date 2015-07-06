class AddMerchantIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :merchant, index: true
  end
end
