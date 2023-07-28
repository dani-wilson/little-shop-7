require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  include ActionView::Helpers::NumberHelper

  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @item1 = @merchant1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10,
                                      status: 0)
    @item2 = @merchant2.items.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 20,
                                      status: 0)

    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer1.invoices.create!(status: 1)

    InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10, status: 0)
    InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 20, status: 0)
  end

  # User Story 15 Testing Begins

  # As a merchant
  # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # Then I see information related to that invoice including:

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

  it 'displays the invoice id and status on the merchants show page' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
  end

  it 'displays the invoice created_at date in the format "Monday, July 18, 2019"' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@invoice1.created_at.strftime('%A, %B %d, %Y'))
  end

  it 'displays the customer first and last name' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@customer1.first_name)
    # User Story 15 Testing End
  end

  # User Story 16 Testing Begins

  # As a merchant
  # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # Then I see all of my items on the invoice including:

  # Item name
  # The quantity of the item ordered
  # The price the Item sold for
  # The Invoice Item status
  # And I do not see any information related to Items for other merchants

  it 'displays item name, quantity, price, and invoice item status for this merchant' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    @invoice1.invoice_items.each do |invoice_item|
      expect(page).to have_content(invoice_item.item.name)
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(number_to_currency(invoice_item.unit_price / 100.0))
      expect(page).to have_content(invoice_item.status)
    end
  end

  it 'does not display any information related to items for other merchants' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    @invoice1.invoice_items.each do |_invoice_item|
      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item2.description)
      expect(page).to_not have_content(number_to_currency(@item2.unit_price / 100.0))
      expect(page).to_not have_content(@item2.status)
    end
  end
end
