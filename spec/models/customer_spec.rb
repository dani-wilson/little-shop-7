require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Associations' do
    it { should have_many :invoices }
  end

  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'Instance Methods' do
    before :each do
      @joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      @cecelia = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
      @mariah = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
      @leanne = Customer.create!(first_name: 'Leanne', last_name: 'Kuhn')
      @sylvester = Customer.create!(first_name: 'Sylvester', last_name: 'Braund')
      @heber = Customer.create!(first_name: 'Heber', last_name: 'Nader')
      @dejon = Customer.create!(first_name: 'Dejob', last_name: 'Hoppe')
      @logan = Customer.create!(first_name: 'Logan', last_name: 'Jenkins')

      @invoice_1 = @joey.invoices.create!()
      @invoice_2 = @joey.invoices.create!(status: 2)
      @invoice_3 = @cecelia.invoices.create!(status: 1)
      @invoice_4 = @mariah.invoices.create!()
      @invoice_5 = @leanne.invoices.create!()
      @invoice_6 = @sylvester.invoices.create!(status: 1)
      @invoice_7 = @heber.invoices.create!()
      @invoice_8 = @dejon.invoices.create!()
      @invoice_9 = @logan.invoices.create!()

      @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
      @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")

      @item_1 = @merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distincti", unit_price: 75107)
      @item_2 = @merchant_1.items.create!(name: "Autem Minima", description: "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non.", unit_price: 67076)
      @item_3 = @merchant_1.items.create!(name: "Ea Voluptatum", description: "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.", unit_price: 32301)
      @item_4 = @merchant_1.items.create!(name: "Nemo Facere", description: "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias", unit_price: 15925)
      @item_5 = @merchant_2.items.create!(name: "Expedita Aliquam", description: "Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.", unit_price: 31163)
      @item_6 = @merchant_2.items.create!(name: "Provident At", description: "Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.", unit_price: 22582)
      @item_7 = @merchant_2.items.create!(name: "Expedita Fuga", description: "Voluptatibus omnis quo recusandae distinctio voluptatem quibusdam et. Voluptas odio accusamus delectus sunt quia. Non atque rerum vitae officia odit.", unit_price: 42629)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 70000, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 6, unit_price: 69000, status: 1)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 32000, status: 2)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 5, unit_price: 16000, status: 0)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 5, unit_price: 19000, status: 1)
      @invoice_item_6 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 7, unit_price: 30000, status: 2)
      @invoice_item_7 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 3, unit_price: 20000, status: 0)
      @invoice_item_8 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_8.id, quantity: 7, unit_price: 45000, status: 1)
      @invoice_item_9 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_9.id, quantity: 4, unit_price: 56000, status: 1)
      
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "success")
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "success")
      @transaction_3 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "failed")
      @transaction_4 = @invoice_2.transactions.create!(credit_card_number: 4515551623735607, credit_card_expiration_date: "04/27", result: "success")
      @transaction_5 = @invoice_2.transactions.create!(credit_card_number: 4515551623735607, credit_card_expiration_date: "04/27", result: "failed")
      @transaction_6 = @invoice_3.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
      @transaction_7 = @invoice_3.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
      @transaction_8 = @invoice_4.transactions.create!(credit_card_number: 4252153331154380, credit_card_expiration_date: "04/27", result: "failed")
      @transaction_9 = @invoice_5.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
      @transaction_10 = @invoice_5.transactions.create!(credit_card_number: 4332881798016631, credit_card_expiration_date: "04/27", result: "success")
      @transaction_11 = @invoice_6.transactions.create!(credit_card_number: 4920121630073678, credit_card_expiration_date: "04/27", result: "success")
      @transaction_12 = @invoice_7.transactions.create!(credit_card_number: 4084466070588807, credit_card_expiration_date: "04/27", result: "success")
      @transaction_13 = @invoice_7.transactions.create!(credit_card_number: 4084466070588807, credit_card_expiration_date: "04/27", result: "success")
      @transaction_14 = @invoice_8.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: "04/27", result: "success")
      @transaction_15 = @invoice_8.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: "04/27", result: "failed")
      @transaction_16 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
      @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
      @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
      @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
    end

    describe "can find the top 5 customers with most # of successful transactions" do
      it "has only 5 results" do
        expected_results = Customer.top_five_with_most_success_transactions
        expect(expected_results.length).to eq(5)
      end
      
      it "has a first name for each customer" do
        expected_results = Customer.top_five_with_most_success_transactions

        expect(expected_results[0].first_name).to eq(@logan.first_name)
        expect(expected_results[1].first_name).to eq(@joey.first_name)
        expect(expected_results[2].first_name).to eq(@heber.first_name)
        expect(expected_results[3].first_name).to eq(@cecelia.first_name)
        expect(expected_results[4].first_name).to eq(@leanne.first_name)
      end

      it "has a last name for each customer" do
        expected_results = Customer.top_five_with_most_success_transactions

        expect(expected_results[0].last_name).to eq(@logan.last_name)
        expect(expected_results[1].last_name).to eq(@joey.last_name)
        expect(expected_results[2].last_name).to eq(@heber.last_name)
        expect(expected_results[3].last_name).to eq(@cecelia.last_name)
        expect(expected_results[4].last_name).to eq(@leanne.last_name)
      end

      it "has a count for each customer" do
        expected_results = Customer.top_five_with_most_success_transactions

        expect(expected_results[0].transaction_count).to eq(4)
        expect(expected_results[1].transaction_count).to eq(3)
        expect(expected_results[2].transaction_count).to eq(2)
        expect(expected_results[3].transaction_count).to eq(2)
        expect(expected_results[4].transaction_count).to eq(2)
      end
    end

    it "Can find all incomplete Invoice IDs (not shipped or completed)" do
      incomplete = Customer.all_incomplete_invoices
      
      expect(incomplete[0].id).to eq(@invoice_1.id)
      expect(incomplete[1].id).to eq(@invoice_4.id)
      expect(incomplete[2].id).to eq(@invoice_5.id)
      expect(incomplete[3].id).to eq(@invoice_7.id)
      expect(incomplete[4].id).to eq(@invoice_8.id)
      expect(incomplete[5].id).to eq(@invoice_9.id)
    end
    
    it "Can find all the incomplete invoice created_ats" do
      incomplete = Customer.all_incomplete_invoices
      
      expect(incomplete[0].created_at).to eq(@invoice_1.created_at)
      expect(incomplete[1].created_at).to eq(@invoice_4.created_at)
      expect(incomplete[2].created_at).to eq(@invoice_5.created_at)
      expect(incomplete[3].created_at).to eq(@invoice_7.created_at)
      expect(incomplete[4].created_at).to eq(@invoice_8.created_at)
      expect(incomplete[5].created_at).to eq(@invoice_9.created_at)
    end
  end
end