require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  # there is only one class method for Merchant, the search_all method. It is tested implicitly in the merchants_requests_spec.rb file at line 77.
end
