require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "my_application_secret"
  end

  helpers UserHelper
  enable :sessions

  get '/' do
    already_logged_in?
    erb :home
  end

  get '/signup' do
    already_logged_in?
    erb :signup
  end

  post '/signup' do
    @user = new_user
    if @user.save
      session[:current_user] = @user
      redirect '/tweets'
    else 
      redirect '/signup'
    end
  end

  get '/login' do 
    already_logged_in?
    erb :login
  end

  post '/login' do
    registered_user?
  end

  get '/logout' do
    if session[:current_user]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end