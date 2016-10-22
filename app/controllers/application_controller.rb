require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "difficult_passphrase"
  end

  get '/' do
    erb :'/application/root'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do

  end

end
