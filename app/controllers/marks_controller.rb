class MarksController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    mark = params[:mark].to_i
    if post && mark >= 1 && mark <= 5
      marks_count = post.marks.size
      average_mark = (marks_count * post.average_mark + mark) / (marks_count + 1)
      ActiveRecord::Base.transaction do
        Mark.create(value: mark, post: post)
        post.update(average_mark: average_mark)
      end
      render json: { average_mark: average_mark.round(2) }, status: '200 OK'
    else
      render json: { error: 'Post_id has to be valid. Mark has to belong the interval between 1 and 5.' },
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
