require 'pry'

class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

#  Signup Page
#     loads the signup page
#     signup directs user to twitter index
#     does not let a user sign up without a username
#     does not let a user sign up without an email
#     does not let a user sign up without a password
#     creates a new user and logs them in on valid submission and does not let a logged in user view the signup page

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

    #   login
    #       loads the login page
    #       loads the tweets index after login
    #       does not let user view login page if already logged in (FAILED - 2)

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

   post '/users/:slug/edit' do    # Get request / show action
     @user = User.find_by_slug(params[:slug])
     erb :'/users/show'     #show
   end

#  logout
#    lets a user logout if they are already logged in
#    does not let a user logout if not logged in
#    does not load /tweets if user not logged in
#    does load /tweets if user is logged in

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

    def slug
      #username.downcase.gsub(" ","-")
     @slug = slugify(self.username)
    end

    def slugify(name)
      split_on_apostrophes = name.split(/[']/)
      name_without_apost = split_on_apostrophes.join
      name_array = name_without_apost.downcase.split(/[\W]/)
      name_array.delete_if{|x|x==""}
      new_name = name_array.join("-")
    end

     def self.find_by_slug(slug)
      self.all.find{|user|user.slug == slug}
    end
  end
end
