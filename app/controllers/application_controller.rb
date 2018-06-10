require './config/environment'

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
    if session.has_key?(:id)
      @user = User.find(session[:id])
      redirect "/tweets"
    else
      erb :signup
    end
  end

  get '/tweets' do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/login" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      redirect "/tweets"
    else
      erb :login
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    binding.pry
    erb :"/users/show"
  end

  post "/signup" do
    if params.values.any?(&:empty?)
      redirect "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      @user = user
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
