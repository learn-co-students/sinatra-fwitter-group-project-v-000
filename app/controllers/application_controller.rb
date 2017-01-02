require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/signup' do
    erb :index
  end

  post '/signup' do
    redirect "/tweets"
  end

  get '/login' do
    erb :"tweets/users/login"
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    Tweet.create(content: params["content"])
    redirect "/tweets/#{Tweet.last.id}"
  end

  get '/tweets/:id' do
    @id = params[:id]
    @tweet = Tweet.find(@id)
    erb :'/tweets/show_tweet'
  end

end