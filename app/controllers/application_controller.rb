require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #mine
    enable :sessions unless test?
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get "/signup" do
    if logged_in?
     redirect to '/tweets'
    end
    erb :'/users/create_user'
  end

  post "/signup" do
    if complete_form?
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    end
    erb :'/users/login'
  end

  post "/login" do
    if complete_form?
      @user = User.find_by(username: params["username"])
    end

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

=begin

it 'loads the tweets index after login' do
  user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
  params = {
    :username => "becky567",
    :password => "kittens"
  }
  post '/login', params
  expect(last_response.status).to eq(302)
  follow_redirect!
  expect(last_response.status).to eq(200)
  expect(last_response.body).to include("Welcome,")
end

=end
  helpers do

    def complete_form?
      params["username"] != "" && params["password"] != "" && params["email"] != "" ? true : false
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end


end
