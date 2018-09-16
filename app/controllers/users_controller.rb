require 'pry'

class UsersController < ApplicationController

  get '/signup' do  # signup / GET request / Create action
    erb :'/users/signup'
  end

  post '/signup' do   #signup / POST request / Create action
    user = User.new(:username =>params[:username], :email =>params[:email], :password =>params[:password])

      if user.save && user.username!="" && user.email!=""
        redirect "/tweets"
      else
        redirect "/signup"
    end
  end

  get "/login" do   #login = Get action
    erb :'/users/login'
  end

  post "/login" do   #login - POST action
    @user = User.find_by(:username => params[:username], :password => params[:password])

    if @user && @user.authenticate(password: params[:password], username: params[:username])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/users/:id' do    # Get request / show action
    @user = User.find_by(params[:user_id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

#helpers do

#    def logged_in?
#      !!session[:user_id]
#    end

#    def current_user
#      User.find(session[:user_id])
#    end
#  end
end
