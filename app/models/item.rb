class Item < ApplicationRecord
  belongs_to :merchant

  def self.search(search_name)
    where("name ILIKE ?", "%#{search_name}%")
    .order('name asc').first
  end
end
