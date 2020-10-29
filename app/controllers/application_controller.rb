require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Welcome to Fwitter"
  end

  get '/signup' do
    signed_in = nil
    "You have reached the signup page"
    if signed_in
      redirect '/tweets'
    else
      "You are not signed in"
    end
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

end
