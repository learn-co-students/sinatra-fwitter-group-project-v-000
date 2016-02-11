require './config/environment'
require 'pry'
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

  get '/signup' do
    if session[:username].nil?
      erb :'user/create_user'
    else
      redirect 'tweets/tweets'
    end
  end

  post '/signup' do
    if (params[:username] == "" || params[:email]=="" || params[:password] =="")
      redirect '/signup'
    else
      session[:username] = params[:username]
      redirect "tweets/tweets"

    end
  end

  get '/login' do

      erb :'user/login'

  end

  post '/login' do
    #
    session[:username] = params[:username]
    @username = User.find_by(username: params[:username])
    #binding.pry
    @tweets = @username.tweets
    redirect "tweets/tweets"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end



end
