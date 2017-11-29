require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "encription_key_that_you_wont_guess"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if session.has_key?(:user_id)
      redirect to '/tweets/tweets'
    else
      erb :'users/login'
    end
  end

  get '/signup' do
    if session.has_key?(:user_id)
      redirect to '/tweets/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'  #how can you raise an error here??? ex: you must fill in the all parts of the form to create an account...
    else
       @user = User.create(username: params[:username], email: params[:email], password: params[:password])
       session[:user_id]=@user.id
       redirect to '/tweets'
     end
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end



end #of class ApplicationController
