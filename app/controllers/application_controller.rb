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
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if (params[:username] == "" || params[:email]=="" || params[:password] =="")
      redirect '/signup'
    else
      session[:username] = params[:username]
      redirect "/tweets"

    end
  end

  get '/login' do
    if session[:username].nil?
      erb :login
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    session[:username] = params[:username]
    @username = User.find_by(params[:username])
    @tweets = @username.tweets
    redirect "/tweets"
  end


end
