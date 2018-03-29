require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  get '/tweets' do
  	erb :'/tweets/tweets'
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

  get '/tweets/:id/edit' do
  	@tweet = Tweet.find_by_id(params[:id])
  	erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	@tweet.update(content: params[:content])
  	@tweet.save
  	redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do 
  	@tweet = Tweet.find_by_id(params[:id])
  	@tweet.delete
  	redirect "/tweets"
  end
end