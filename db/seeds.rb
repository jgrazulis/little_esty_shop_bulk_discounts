# merchant_1 = Merchant.create!(name: 'Bob Belcher')
# merchant_2 = Merchant.create!(name: 'Tina Belcher')

# discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
# discount_2 = merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
# discount_3 = merchant_1.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)

# item_1 = merchant_1.items.create!(name: "dog sweater", description: "sweater for dogs", unit_price: 100, status: 0)
# item_2 = merchant_1.items.create!(name: "dog shoes", description: "shoes for dogs", unit_price: 100, status: 0)
# item_3 = merchant_1.items.create!(name: "dog collar", description: "a collar for dogs' necks", unit_price: 100, status: 0)
# item_4 = merchant_1.items.create!(name: "dog toy", description: "a toy for dogs", unit_price: 100, status: 1)
# item_5 = merchant_1.items.create!(name: "makeup", description: "something to emphasize your features", unit_price: 100)

# customer_1 = Customer.create!(first_name: "Leslie", last_name: "Knope")
# customer_2 = Customer.create!(first_name: "Tom", last_name: "Haverford")

# invoice_1 = customer_1.invoices.create!(status: 1)
# invoice_2 = customer_1.invoices.create!(status: 1)
# invoice_3 = customer_2.invoices.create!(status: 1)
# invoice_4 = customer_2.invoices.create!(status: 1)

# invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price, quantity: 2, status: 0)
# invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price, quantity: 2, status: 0)
# invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: item_3.unit_price, quantity: 2, status: 0)
# invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, unit_price: item_4.unit_price, quantity: 2, status: 1)

# transaction_1 = invoice_1.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')
# transaction_2 = invoice_2.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')
# transaction_3 = invoice_3.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')
# transaction_4 = invoice_4.transactions.create!(credit_card_number: 123456, credit_card_expiration_date: 1223, result: 'success')
