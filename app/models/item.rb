class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_all(search_name)
    where("name ILIKE ?", "%#{search_name}%")
    # .order('name desc')
  end
end
