require 'pry'

class UsersController < ApplicationController

  get '/signup' do  # signup / GET request / Create action
    erb :'/users/signup'
  end

  post '/signup' do   #signup / POST request / Create action
    @user = User.create(:username =>params[:username],
    :email =>params[:email],
    :password =>params[:password])

    if @user.save
      redirect '/signup'
    else
      redirect "/tweets"
    end
  end

  get "/login" do   #login = Get action
    erb: '/login'
  end

  post "login" do   #login - POST action
    @user = User.find_by(:username => params[:username], :password => params[:password])
    if user && user.authenticate(params[:password], params[:username])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/users/login"
    end
  end

  get '/users/:id' do    # Get request / show action
    @user = User.find_by(params[:user_id])
    erb :'/users/show'
  end

end
