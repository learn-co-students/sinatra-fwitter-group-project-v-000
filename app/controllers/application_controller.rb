require './config/environment'
require './app/helpers/helpers.rb'
class ApplicationController < Sinatra::Base

  extend Helpers

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
    @user = User.find_by(id: session[:user_id])
    if !@user.nil?
      if @user.id == session[:user_id]
        redirect to '/tweets'
      end
    else
      erb :signup
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    erb :'/tweets/index'
  end

  get '/login' do
    erb :'/users/login'
  end

end