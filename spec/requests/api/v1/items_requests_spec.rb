require 'rails_helper'

RSpec.describe 'The Items API' do
  it 'gets a list of all items' do
    create_list(:item, 4)
    get '/api/v1/items'

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(response.status).to eq(200)
    expect(response).to be_successful
    expect(items.count).to eq(4)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a String
      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end

  context 'show' do
    it 'gets one specific item' do
      merchant = create :merchant
      item = create :item, { merchant_id: merchant.id }

      get "/api/v1/items/#{item.id}"

      expect(response.status).to eq(200)
      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)
      item = parsed[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a String
      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end

    describe 'sad path' do
      it 'returns error message if no item found' do
        merchant = create :merchant
        item = create :item, { merchant_id: merchant.id }

        get "/api/v1/items/#{item.id + 1}"

        parsed = JSON.parse(response.body, symbolize_names: true)
        item = parsed[:data]
# require 'pry'; binding.pry
        expect(item[:message]).to eq("No item matches this id")
        expect(response.status).to eq(404)
      end
    end
  end

  it 'can create an item' do
    merchant = create :merchant
    item_params = {
      name: 'left-handed back scratcher',
      description: 'scratch that back, lefty',
      unit_price: 12.5,
      merchant_id: merchant.id
    }

    post '/api/v1/items', params: item_params

    expect(response).to be_successful
    expect(response.status).to eq(201)

    item = Item.last

    expect(item.name).to eq('left-handed back scratcher')
    expect(item.description).to eq('scratch that back, lefty')
    expect(item.unit_price).to eq(12.5)
    expect(item.merchant_id).to eq(merchant.id)
  end

  describe 'sad path' do
    it 'returns 404 if item attributes not defined correctly' do
      merchant = create :merchant
      item_params = {
        name: 'left-handed back scratcher',
        description: 'scratch that back, lefty',
        unit_price: 12.5,
        merchant_id: 00000
      }

      post '/api/v1/items', params: item_params

      expect(response.status).to eq(404)
    end
  end

  it 'can delete an item' do
    merchant = create :merchant
    item = create(:item, merchant_id: merchant.id)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(response.status).to be(204)
    expect(merchant.items.count).to eq(0)
  end

  it 'can update an item' do
    item = create(:item, name: "Fake name")

    put "/api/v1/items/#{item.id}", params: {name: "Real name"}

    expect(response).to be_successful
    expect(Item.last.name).to eq("Real name")
  end

  it 'can get the merchant data for a given item' do
    merchant1 = create :merchant
    merchant2 = create :merchant
    item = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item.id}/merchant"

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data] #turning the JSON into a hash so we can test more easily
    #removed the attribute :id from the merchant serializer
    expect(response).to be_successful
    expect(merchant[:id]).to be_a String
    expect(merchant[:id]).to eq(merchant1.id.to_s)
  end

  it 'can find all items matching name search terms' do
    item_1 = create(:item, name: "Dog bowl")
    item_3 = create(:item, name: "Dogmatic Litany")
    item_2 = create(:item, name: "Ceramic dog")
    item_4 = create(:item, name: "Chocolate Milky Way")

    name = "Dog"
    get "/api/v1/items/find_all?name=#{name}"

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]
# require 'pry'; binding.pry
    expect(response).to be_successful
    expect(items.class).to eq(Array)
    expect(items.count).to eq(3)
    expect(items.first[:attributes][:name]).to eq(item_1.name)
    expect(items.second[:attributes][:name]).to eq(item_3.name)
    #this asserts that the search includes partial matches
    expect(items.third[:attributes][:name]).to eq(item_2.name)
    #this asserts that the search is case insensitive
  end
end
