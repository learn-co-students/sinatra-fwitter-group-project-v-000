require 'pry'

class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do  # signup / GET request / Create action
    if logged_in? && @user = current_user
      redirect "/tweets"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do   #signup / POST request / Create action
    @user = User.new(params)   #  @user = User.new(:username =>params[:us@rname], :email =>params[:email], :password =>params[:password])
      if @user.save
        session[:user_id] = @user.id
				redirect "/tweets"
			else
				redirect "/signup"
			end
		end

  get "/login" do   #login = Get action
    if logged_in?     # @user = current_user
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do   #login - POST action
    @user = User.find_by(:username => params[:username])   #@user = User.find_by(:username => params[:username], :password => params[:password])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/signup"
      end
  end

   get '/users/show' do    # Get request / show action
     @user = User.find_by(params[:id])  #@user = User.find_by(:username => params[:username], :password => params[:password])
     erb :'/users/show'
   end

   get '/users/:slug' do    # Get request / show action
     @user = User.find_by_slug(params[:slug])
     erb :'/users/show'     #show
   end

  get '/logout' do   # Get request / logout action
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/tweets'
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
