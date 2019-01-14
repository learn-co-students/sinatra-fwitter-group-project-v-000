require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  #USERS CONTROLLER

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
      erb :'/users/signup'

    end
  end

    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      end
    end
