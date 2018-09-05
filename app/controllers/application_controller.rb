require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
 get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #your code here
      if params[:username].empty?
      redirect to '/failure'
    end
      user = User.new(:username => params[:username], :password => params[:password])
	  if user.save
    redirect "tweets/tweets"
  else
    redirect "/failure"
  end

  end

  get '/tweets' do
    @user = User.find(session[:user_id])
    erb :"tweets/tweets"
  end


  get "/login" do
    erb :login
  end

  post "/login" do
   user = User.find_by(:username => params[:username])
 
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect "tweets/tweets"
   else
     redirect "/failure"
   end
    ##your code here
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
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


