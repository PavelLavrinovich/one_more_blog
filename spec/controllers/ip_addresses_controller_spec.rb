require 'rails_helper'

RSpec.describe IpAddressesController, type: :controller do
  describe 'GET #index' do
    fixtures :users
    fixtures :ip_addresses
    fixtures :user_ip_addresses

    before do
      get :index
      @response_body = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns a json with a list of suspicious ip addresses' do
      expect(@response_body.first.keys.first.to_s).
        to be == '192.168.0.0.42'
    end

    it 'returns a json with a list of logins for every address' do
      expect(@response_body.first.values.first).
        to be == ['Existing login', 'Suspicious login']
    end

    it 'returns the 200 OK status code' do
      expect(response.status).to be == 200
    end
  end
end
