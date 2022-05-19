class MerchantSerializer
  include JSONAPI::Serializer
  attributes  :name

  # has_many :items

  #example of how to handroll the serializer:
  # def self.format_merchants
  #   {
  #     data: merchants.map do |merchant|
  #       {
  #         id: merchant.id,
  #         type: 'merchant',
  #         attributes: {
  #           name: merchant.name
  #             },
  #         relationships: {
  #           items: merchant.items.map do |item|
  #             {
  #               id: item.id,
  #               type: 'item'
  #             }
  #           end
  #         }
  #       }
  #     end
  #   }
  # end
end
