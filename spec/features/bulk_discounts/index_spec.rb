require 'rails_helper'

RSpec.describe 'Bulk Discounts Index' do
  let!(:merchant_1) {Merchant.create!(name: 'Bob Belcher')}
  let!(:merchant_2) {Merchant.create!(name: 'Tina Belcher')}

  let!(:discount_1) {merchant_1.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 100)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)}
  let!(:discount_3) {merchant_1.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)}
  let!(:discount_4) {merchant_2.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 21)}

  let!(:item_1) {merchant_1.items.create!(name: "dog sweater", description: "sweater for dogs", unit_price: 100, status: 0)}
  let!(:item_2) {merchant_1.items.create!(name: "dog shoes", description: "shoes for dogs", unit_price: 100, status: 0)}
  let!(:item_3) {merchant_1.items.create!(name: "dog collar", description: "a collar for dogs' necks", unit_price: 100, status: 0)}
  let!(:item_4) {merchant_1.items.create!(name: "dog toy", description: "a toy for dogs", unit_price: 100, status: 1)}
  let!(:item_5) {merchant_1.items.create!(name: "makeup", description: "something to emphasize your features", unit_price: 100)}

  let!(:customer_1) {Customer.create!(first_name: "Leslie", last_name: "Knope")}
  let!(:customer_2) {Customer.create!(first_name: "Tom", last_name: "Haverford")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_2) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_3) {customer_2.invoices.create!(status: 1)}
  let!(:invoice_4) {customer_2.invoices.create!(status: 1)}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: item_3.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, unit_price: item_4.unit_price, quantity: 2, status: 1)}

  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')}

  before(:each) do
    visit merchant_bulk_discounts_path(merchant_1.id)
  end

  it 'shows all bulk discounts with their percentage discount and quantity threshold' do
    expect(page).to have_content(discount_1.percentage_discount)
    expect(page).to have_content(discount_1.quantity_threshold)

    expect(page).to have_content(discount_2.percentage_discount)
    expect(page).to have_content(discount_2.quantity_threshold)

    expect(page).to have_content(discount_3.percentage_discount)
    expect(page).to have_content(discount_3.quantity_threshold)
  end

  it 'shows all bulk discounts as links to its show page' do
    expect(page).to have_link("Link to Discount ##{discount_1.id}")
    expect(page).to have_link("Link to Discount ##{discount_2.id}")
    expect(page).to have_link("Link to Discount ##{discount_3.id}")
    expect(page).to_not have_link("Link to Discount ##{discount_4.id}")
  end

  it 'has link to create a new discount' do
    click_link("Create New Discount")
    expect(current_path).to eq(new_merchant_bulk_discount_path(merchant_1.id))

    fill_in 'Percentage discount', with: 30
    fill_in 'Quantity threshold', with: 20
    click_button "Create Discount"

    expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1.id))
    expect(page).to have_content(30)
    expect(page).to have_content(20)
  end

  it 'has link to delete each discount' do
    expect(page).to have_content(discount_1.percentage_discount)
    click_link("Delete ##{discount_1.id}")

    expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1.id))
    expect(page).to_not have_content(discount_1.percentage_discount)
  end
end