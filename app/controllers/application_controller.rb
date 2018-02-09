
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end


  get '/' do
    erb :index
  end


  get '/signup' do

    if logged_in?
      erb :tweets
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params["username"], password: params["password"], email: params["email"] )
    @user.save
    if @user.username != "" && @user.password != "" && @user.email != ""
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  #
  # get '/login' do
  #
  # end
  #
  # post '/login' do
  #
  # end




end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
