require 'rails_helper'

RSpec.describe 'The Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(response.status).to eq(200)
    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a String
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  context 'show' do
    it 'can return a specific merchant' do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)
# require 'pry'; binding.pry
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_a String
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a String
    end

    describe 'sad path' do
      it 'returns an error if no merchant found' do
        id = create(:merchant).id
        get "/api/v1/merchants/#{id + 1}"

        parsed = JSON.parse(response.body, symbolize_names: true)
        merchant = parsed[:data]

        expect(merchant).to eq({ message: 'No merchant matches this id'})
      end
    end
  end

  describe 'the merchant search' do
    it 'can find one merchant based on search criteria' do
      merchant_1 = Merchant.create!(name: "Billy Bob's Bug Boutique")
      merchant_2 = Merchant.create!(name: "Candy Crusher's Cinnamon Centipedes")

      get "/api/v1/merchants/find?name=Billy"
      #this route is sent to the SearchesController, action: find
      parsed = JSON.parse(response.body, symbolize_names: true)
      merchant = parsed[:data]

      expect(response.status).to eq(200)
      expect(response).to be_successful
      expect(merchant[:attributes][:name]).to eq(merchant_1.name)
    end

    it 'returns error message if no merchant found by that name' do
      merchant_1 = Merchant.create!(name: "Billy Bob's Bug Boutique")

      get "/api/v1/merchants/find?name=Alex"

      parsed = JSON.parse(response.body, symbolize_names: true)
      response_data = parsed[:data][:message]

      expect(response.status).to eq(200)
      expect(response).to be_successful
      expect(response_data).to eq("No merchant found")
    end

    it 'can find all merchants that match a search term' do
      merchant_1 = Merchant.create!(name: "Billy Bob's Bug Boutique")
      merchant_2 = Merchant.create!(name: "Bob's Burgers")
      merchant_3 = Merchant.create!(name: "Jimbob's Jangles")
      merchant_4 = Merchant.create!(name: "Jim's Jams")

      name = 'Bob'

      get "/api/v1/merchants/find_all?name=#{name}"

      parsed = JSON.parse(response.body, symbolize_names: true)
      merchants = parsed[:data]
# require 'pry'; binding.pry
      expect(response.status).to eq(200)
      expect(response).to be_successful
      expect(merchants.class).to eq(Array)
      expect(merchants.count).to eq(3)
      expect(merchants.first[:attributes][:name]).to eq("Billy Bob's Bug Boutique")
      expect(merchants.second[:attributes][:name]).to eq("Bob's Burgers")
      expect(merchants.third[:attributes][:name]).to eq("Jimbob's Jangles")
    end
  end

  describe 'merchant items' do
    it 'returns all items associated with a given merchant' do
      merchant = create :merchant
      item1 = create :item, { merchant_id: merchant.id }
      item2 = create :item, { merchant_id: merchant.id }
      item3 = create :item, { merchant_id: merchant.id }

      get "/api/v1/merchants/#{merchant.id}/items"

      parsed = JSON.parse(response.body, symbolize_names: true)
      items = parsed[:data]
# require 'pry'; binding.pry
      expect(response.status).to eq(200)
      expect(response).to be_successful
      expect(merchant.items.count).to eq(3)

      items.each do |item|
        expect(item[:id]).to be_a String
        expect(item).to have_key(:attributes)
        expect(item[:attributes][:name]).to be_a String
        expect(item[:attributes][:description]).to be_a String
        expect(item[:attributes][:unit_price]).to be_a Float
        expect(item[:attributes][:merchant_id]).to eq(merchant.id)
      end
    end

    describe 'sad paths' do
      it 'returns 404 if no items are found for that merchant' do
        merchant = create :merchant
        get "/api/v1/merchants/#{merchant.id}/items"

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(404)
        expect(parsed).to have_key(:error)
        expect(parsed[:error][:message]).to eq("No items were found for merchant with id: #{merchant.id}")
      end
    end
  end
end
