require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :index
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/tweets/tweets'
    end
  end

end
