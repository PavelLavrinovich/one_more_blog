require 'rails_helper'

RSpec.describe MarksController, type: :controller do
  describe 'POST #create' do
    fixtures :posts
    fixtures :marks

    before do
      @request_params = {
        post_id: Post.first.id,
        mark: 5
      }
      @marks_count = Mark.all.size
      post :create, params: @request_params
      @response_body = JSON.parse(response.body, symbolize_names: true)
    end

    it 'creates a mark' do
      expect(Mark.all.size).to be == @marks_count + 1
    end

    it 'creates a mark for the post' do
      expect(Post.first.marks.size).to be == 2
    end

    it 'returns an average mark for the post' do
      expect(@response_body[:average_mark]).to be == '3.5'
    end

    it 'returns the 200 OK status code' do
      expect(response.status).to be == 200
    end
  end
end
