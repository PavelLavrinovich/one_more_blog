require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    fixtures :users
    context 'with valid params' do
      before do
        @request_params = {
          login: 'Test login',
          title: 'Test title',
          description: 'Test description'
        }
        post :create, params: @request_params
        @response_body = JSON.parse(response.body, symbolize_names: true)
      end

      it 'increases a count of posts by one' do
        expect(Post.all.size).to be == 1
      end

      it 'increases a count of users by one' do
        expect(User.all.size).to be == 2
      end

      it 'associates a new post with a the new user' do
        expect(User.last.posts.size).to be == 1
      end

      it 'returns a json that contains a title of the post' do
        expect(@response_body[:title]).to be == @request_params[:title]
      end

      it 'returns a json that contains a description of the post' do
        expect(@response_body[:description]).to be == @request_params[:description]
      end

      it 'returns the 200 OK status code' do
        expect(response.status).to be == 200
      end
    end

    context 'with an existing login' do
      before do
        @request_params = {
          login: 'Existing login',
          title: 'Test title',
          description: 'Test description'
        }
        post :create, params: @request_params
        @response_body = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not increase a count of users by one' do
        expect(User.all.size).to be == 1
      end

      it 'associates a new post with a the new user' do
        expect(User.last.posts.size).to be == 1
      end
    end

    context 'with invalid attributes' do
      before do
        @request_params = {
          login: 'Test login',
          title: '',
          description: ''
        }
        post :create, params: @request_params
        @response_body = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not save the post' do
        expect(Post.all.size).to be == 0
      end

      it 'does not save the user' do
        expect(User.all.size).to be == 1
      end

      it 'returns an error message' do
        expect(@response_body[:error]).to be == 'Title and description can not be blank'
      end

      it 'returns the 422 Unprocessable Entity status code' do
        expect(response.status).to be == 422
      end
    end
  end
end
