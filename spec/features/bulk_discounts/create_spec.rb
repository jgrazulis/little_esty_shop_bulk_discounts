require 'rails_helper'

RSpec.describe 'Create New Bulk Discount' do
  let!(:merchant_1) {Merchant.create!(name: 'Bob Belcher')}
  let!(:merchant_2) {Merchant.create!(name: 'Tina Belcher')}

  let!(:discount_1) {merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)}
  let!(:discount_3) {merchant_1.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)}
  let!(:discount_4) {merchant_2.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 21)}

  it 'merchant fills out new dicount form' do
    expect(merchant_1.bulk_discounts.count).to eq(3)
    visit new_merchant_bulk_discount_path(merchant_1.id)
    fill_in 'Percentage discount', with: 20
    fill_in 'Quantity threshold', with: 10
    click_button "Create Discount"

    expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1.id))
    expect(merchant_1.bulk_discounts.count).to eq(4)
  end
end