require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweeet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params["tweet"])
    @tweet.save
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.save
    redirect to "tweets/#{@tweet.id}"
  end

end
