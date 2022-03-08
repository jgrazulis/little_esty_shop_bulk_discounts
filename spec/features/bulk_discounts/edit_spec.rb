require 'rails_helper'

RSpec.describe 'Edit Bulk Discount Form' do
  let!(:merchant_1) {Merchant.create!(name: 'Bob Belcher')}
  let!(:discount_1) {merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}

  it 'has field to update discount info' do
      visit edit_merchant_bulk_discount_path(merchant_1.id, discount_1.id)
      expect(page).to have_field('Percentage discount', with: 20)
      expect(page).to have_field('Quantity threshold', with: 10)
  
      fill_in 'Percentage discount', with: 30
      fill_in 'Quantity threshold', with: 15
      click_button 'Submit'

      expect(current_path).to eq(merchant_bulk_discount_path(merchant_1.id, discount_1.id))
      expect(page).to have_content(30)
      expect(page).to have_content(15)
    end
  end