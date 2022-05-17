class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
  # NOTE ON HAND_ROLLING SERIALIZERS AND CUSTOM JSON 
  # def self.format_items(items)
  #   {
  #     data: items.map do |item|
  #       {
  #         id: item.id,
  #         type: 'item',
  #         attributes: {
  #           name: item.name,
  #           description: item.description,
  #           unit_price: item.unit_price,
  #           merchant_id: item.merchant_id
  #         }
  #       },
  #     end
  #   }
  # end
  #if you wanted to include some custom attributes in your JSON response, you would do so like this:
  # attribute :attribute_name do |object| (here, object is item)
  #   item.attribute.method
  #end
  #EXAMPLE from 'build api workshop complete branch' of Turing practice repo
  # in class StoreSerializer
  # attribute :num_books do |store|
  #  store.books.count
  # end
end
