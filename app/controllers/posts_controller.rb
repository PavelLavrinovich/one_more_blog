class PostsController < ApplicationController
  def create
    ip_address = IpAddress.find_or_create_by(address: request.remote_ip)
    user = User.find_or_create_by(login: params[:login])
    ip_address.users << user unless ip_address.users.include? user
    ip_address.update(suspicious: true) if ip_address.users.size > 1
    if !params[:title].empty? && !params[:description].empty?
      post = Post.create(
        title: params[:title],
        description: params[:description],
        user: user, ip_address: ip_address
      )
      render json: post.to_json, status: '200 OK'
    else
      render json: { error: 'Title and description can not be blank' }.to_json,
             status: '422 Unprocessable Entity'
    end
  end
end
