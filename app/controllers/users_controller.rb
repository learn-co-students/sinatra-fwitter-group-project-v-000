require 'rack-flash'
 #require 'flash'
class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by(params[:slug])
    erb :'users/show'
  end


    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
        # flash[:message] = "Welcome to Fwitter! Please sign up."
      else
        redirect '/tweets'
      end
    end


    post '/signup' do
      # binding.pry
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
      else
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user_id
        redirect '/tweets'
      end
    end


    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect '/tweets'
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


    # put
    # end
    #
    # delete
    # end



end
