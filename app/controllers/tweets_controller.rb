require 'rack-flash'
class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    @tweets = Tweet.all
    
    logged_in? ? (erb :'tweets/tweets') : (redirect '/login')
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])

    erb :'tweets/show_tweet'
  end

end
