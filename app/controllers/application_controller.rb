require './config/environment'
require '/sinatra/flash'

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

  post '/signup' do
    if params[:user].any? {|a| a == [] || a == "" || a == nil}
      redirect "/error"
    else
      User.create(params[:user])
      redirect "/tweets"
    end
  end

  get '/tweets' do
    erb :show
  end

  get '/error' do
    erb :error
    redirect "/signup"
  end

end
