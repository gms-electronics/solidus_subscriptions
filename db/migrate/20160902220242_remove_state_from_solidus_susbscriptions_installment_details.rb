class RemoveStateFromSolidusSusbscriptionsInstallmentDetails < ActiveRecord::Migration
  def change
    remove_column :solidus_subscriptions_installment_details, :state, :string
  end
end
