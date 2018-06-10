class IpAddressesController < ApplicationController
  def index
    ip_adresses = IpAddress.where(suspicious: true)
    json = ip_adresses.map do |ip_address|
      { ip_address.address => ip_address.users.map(&:login)}
    end
    render json: json, status: '200 OK'
  end
end
