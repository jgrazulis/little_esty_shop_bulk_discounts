require 'rails_helper'

RSpec.describe 'Bulk Discounts Show' do
  let!(:merchant_1) {Merchant.create!(name: 'Bob Belcher')}
  let!(:merchant_2) {Merchant.create!(name: 'Tina Belcher')}

  let!(:discount_1) {merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 15)}

  before(:each) do
    visit merchant_bulk_discount_path(merchant_1.id, discount_1.id)
  end

  it 'shows bulk discounts percentage discount and quantity threshold' do
    expect(page).to have_content(discount_1.percentage_discount)
    expect(page).to have_content(discount_1.quantity_threshold)
    expect(page).to_not have_content(discount_2.percentage_discount)
    expect(page).to_not have_content(discount_2.quantity_threshold)
    # save_and_open_page
  end

  it 'has link to edit bulk discount' do
    expect(page).to have_content(20)
    click_link("Edit Discount ##{discount_1.id}")

    expect(current_path).to eq(edit_merchant_bulk_discount_path(merchant_1.id, discount_1.id))
    fill_in 'Percentage discount', with: 10
    click_button 'Submit'
    expect(current_path).to eq(merchant_bulk_discount_path(merchant_1.id, discount_1.id))
    expect(page).to have_content(10)
  end
end