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
  end
end
