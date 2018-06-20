require './config/environment'

class UsersController < Sinatra::Base

#Signup Page
  get '/signup' do
    #does not let a logged in user view the signup page
    erb :'/users/create_user'
  end

#Signup Page- Form Submit
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/failure'
    else
      @user = User.create(
        :username => params["user"]["username"],
        :email => params["user"]["email"],
        :password => params["user"]["password"]
      )
      @user.save
      redirect to "/tweets"
    end
  end

#Login Page
  get '/login' do
    erb :'/users/login'
  end

#Login Page- Form Submit
  post '/login' do
    #log in user here
    redirect to "/tweets"
  end

#User's Show page
  get '/users/:slug' do
    @user = User.find_by_slug(:slug)
    erb :'/users/show'
  end

end #UsersController Class end tag
