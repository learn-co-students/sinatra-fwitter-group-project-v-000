require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, 'secret string'

    use Rack::Flash
  end


  get '/' do
    erb :index
  end


  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome, #{user.username}!"
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end


end