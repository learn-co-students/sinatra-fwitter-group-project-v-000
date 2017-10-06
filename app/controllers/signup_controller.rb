require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/signup' do
    if Helper.is_logged_in?(session)
       redirect :tweets
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])

    if user.save && params[:username] != "" && params[:email] != ""
      session[:user_id] = user.id
      redirect :tweets
    else
      redirect '/signup'
    end

  end

end
