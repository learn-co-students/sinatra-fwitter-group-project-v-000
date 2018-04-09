require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get  '/signup' do
    erb :signup
  end

  get '/tweets' do
    erb :tweets
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      #create a user
      #@user = User.create(name: params[:username], email: params[:email], password: params[:password])
      #@user.save
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  helpers do
    def logged_in?
      #returns true if logged in
      !session[:user_id]
    end
  end

end
