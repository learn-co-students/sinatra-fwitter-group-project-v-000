require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    erb :index
  end

#Create The Tweet - C
  get '/tweets/new' do

    erb :'tweets/create_tweet'
  end

  post '/tweets' do

    redirect to "/tweets/#{@tweet.id}"
  end

#Show The Tweet - R

  get '/tweets' do

    erb :'tweets/tweets'
  end

  get '/tweets/:id' do

    erb :'tweets/show_tweet'
  end

  #Edit the Tweet - U

  get '/tweets/:id/edit' do

    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do

    erb :'tweets/show_tweet'
  end

  #Delete Tweet - D

  post '/tweets/:id/delete' do

    redirect to "/tweets"
  end
end
