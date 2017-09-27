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

  get '/tweets/new' do
    logged_in? ? (erb :'tweets/create_tweet') : (redirect '/login')
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      tweet = Tweet.create(content: params[:content])
      # binding.pry
      tweet.user = User.find(session[:user_id])

      tweet.save

      # redirect "/tweets/#{tweet.id}"
    end

  end
end
