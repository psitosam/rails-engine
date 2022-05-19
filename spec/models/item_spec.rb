require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

# there is only one class method for Item, the search_all method. It is tested implicitly in the items_requests_spec.rb file at line 135.
end
