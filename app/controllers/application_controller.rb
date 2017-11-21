require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'super_secret_phrase'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params.value?("")
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end


end
