require './config/environment'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  before /\/(signup|login)/ do
    redirect '/tweets' if current_user
  end

  before '/tweets' do
    redirect '/login' unless current_user
  end
  
  get '/' do
    erb :index
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end
end