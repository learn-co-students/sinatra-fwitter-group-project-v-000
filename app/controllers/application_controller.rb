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
    if !params.value("")
      @user = User.create(params)
      redirect 'tweets/tweets'
    else
      redirect 'users/create_user'
    end
  end


end
