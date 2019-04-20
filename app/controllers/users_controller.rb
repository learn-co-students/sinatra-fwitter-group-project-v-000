require 'rack-flash'
 # require 'flash'
class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by(params[:slug])
    erb :'users/show'
  end


    get '/signup' do
      if !logged_in?
        erb :'users/signup'
        # flash[:message] = "Welcome to Fwitter!"
      else
        redirect 'tweets/index'
      end
    end


    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect 'users/signup'
      else
        # @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @user = User.new(name: params["name"], email: params["email"], password: params["password"])

        @user.save
        session[:user_id] = @user.id
        redirect '/index'
      end
    end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect 'tweets/tweets'
      end
    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
    redirect '/tweets'
  else
    redirect '/signup'
    end
  end


    get '/logout'do
      if logged_in?
        session.destroy
        redirect '/login'
      else
        redirect to '/'
      end
    end
end
# ****************
# My Previous Lab
#   post "/signup" do
#     if params[:username] == "" || params[:password] == ""
#       redirect '/failure'
#     else
#       User.create(username: params[:username], password: params[:password])
#       redirect '/login'
#     end
#
#   end
#
#   get '/account' do
#     @user = User.find(session[:user_id])
#     erb :account
#   end
#
#
#   get "/login" do
#     erb :login
#   end
#
#   post "/login" do
#     @user = User.find_by(username: params[:username])
#     if @user && @user.authenticate(params[:password])
#       session[:user_id] = @user.id
#       redirect to "/account"
#     else
#       redirect to "/failure"
#     end
#   end
#
#   get "/failure" do
#     erb :failure
#   end
#
#   get "/logout" do
#     session.clear
#     redirect "/"
#   end
#
#   helpers do
#     def logged_in?
#       !!session[:user_id]
#     end
#
#     def current_user
#       User.find(session[:user_id])
#     end
#   end
#
# end
# ****************
