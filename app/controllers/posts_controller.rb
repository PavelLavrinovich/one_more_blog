class PostsController < ApplicationController
  def create
    if !params[:title].empty? && !params[:description].empty?
      ip_address = IpAddress.find_or_create_by(address: request.remote_ip)
      user = User.find_or_create_by(login: params[:login])
      ip_address.users << user unless ip_address.users.include? user
      ip_address.update(suspicious: true) if ip_address.users.size > 1
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

  def index
    posts = Post.order('average_mark DESC').limit(params[:n]).map do |post|
      {
        title: post.title,
        description: post.description
      }
    end
    render json: posts.to_json, status: '200 OK'
  end
end
