require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  get '/tweets/new' do
  	erb :'/tweets/create_tweet'
  end

  post '/tweets' do
  	@tweet = Tweet.new(content: params[:content])
  	@tweet.save
  	redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	erb :'/tweets/show_tweet'
  end
end