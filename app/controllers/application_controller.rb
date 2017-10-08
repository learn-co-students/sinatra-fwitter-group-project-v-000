require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
      enable :sessions
      set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/users' do
    @user = User.new(username: params['username'], email: params['email'], password: params['password'])
    @user.save

    redirect '/tweets'
  end

  get '/tweets' do
    erb :'tweets/main'
  end

end