require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "passwort_sehr_sicher"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in? #doesn't load signup page if user is logged in
      redirect to '/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      #add || to check if email includes @ + .com?
      flash[:message] = "Please enter all fields with required information"
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets/tweets'
    end
  end

  get '/tweets/tweets' do
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/login' do
    if logged_in? #doesn't load signup page if user is logged in
      redirect to '/tweets/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets/tweets'
    else
      flash[:message] = "Login information incorrect"
      redirect to '/login'
    end
  end


  helpers do
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end

end
