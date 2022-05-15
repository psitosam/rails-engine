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
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  context 'show' do
    it 'can return a specific merchant' do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a String
    end

    describe 'sad path' do
      it 'returns an error if no merchant found' do
        id = create(:merchant).id
        get "/api/v1/merchants/#{id + 1}"

        parsed = JSON.parse(response.body, symbolize_names: true)
        merchant = parsed[:data]

        expect(merchant).to eq({ details: 'No merchant matches this id'})
      end
    end
  end
end
