require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'layout'
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    #TO DO in this route:
    #Instantiate User info by going into pry and working with params!
    redirect to "tweets/tweets"
  end

end
