require 'pry'

class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do  # signup / GET request / Create action
    if logged_in? && @user = current_user
      redirect "/tweets"
    if !logged _in? && !@user = current_user
      redirect "/signup"
    end
    end
  end

  post '/signup' do   #signup / POST request / Create action
  	@user = User.new(params)   #  @user = User.new(:username =>params[:username], :email =>params[:email], :password =>params[:password])
      if @user.save
        session[:user_id] = @user.id
				redirect "/tweets"
			else
				redirect "/signup"
			end
		end

  get "/login" do   #login = Get action
    if logged_in? && @user = current_user
      redirect "/tweets"
      if !logged_in? && !@user = current_user
        redirect "/users/login"
      end
    end
  end

  post "/login" do   #login - POST action
    @user = User.find_by(params)   #@user = User.find_by(:username => params[:username], :password => params[:password])
      if @user && @user.authenticate(password: params[:password], username: params[:username])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/users/login"
      end
  end

  get '/users/:id' do    # Get request / show action
    @user = User.find_by(params)
    erb :'/users/show'
  end

#  get '/users/:slug' do    # Get request / show action
#    @user = User.find_by_slug(params[:slug])
#    erb :'/users/show'
#  end

  get '/users/show' do
    @user = User.find_by(params)   #@user = User.find_by(:username => params[:username], :password => params[:password])
    erb :'/users/show'
  end

  patch '/users/show' do
    @user = User.find_by(params[:slug])
    @user.username = User.find_by(username: params[:username])
    @user.username = update.(params[:slug])
    slug = @user.slug
     @user.save
    erb :'/users/#{user.slug}'
  end

  get '/logout' do   # Get request / logout action
    if logged_in? && @user = current_user
        session.clear
      else
        redirect "/login"
      end
    end

helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def self.find_by_slug(slug)
      self.all.detect{|x|x.slug == slug}
    end

    def slugify
      split_on_apostophes = username.split(/[']/)
      username_without_apost = split_on_apostophes.join
      username_array = name_without_apost.downcase.split(/[\W]/)
      username_array.delete_if{|x|x==""}
      new_username = username_array.join("-")
    end

  end
end
