require 'pry'
class UsersController < ApplicationController

    get '/signup' do
      if !Helpers.logged_in?(session)
        erb :'/users/create_user'
      else
        redirect '/tweets'
      end
    end

    post '/signup' do
      if params[:email] != "" && params[:email].include?("@") && params[:email].include?(".") && params[:username] != "" && params[:password] != ""
        #use method to validate email?
          user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
  		    user.save
          session[:user_id] = user.id
          redirect "/tweets"
        else
         	 redirect "/signup" 
        end
    end

    get "/login" do
      if Helpers.logged_in?(session)
        redirect '/tweets'
      else
        erb :'/users/login'
      end
    end

    post "/login" do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
      else
          redirect "/signup"
      end
    end

    get "/users/:slug" do
      @user = Helpers.current_user(session) #or find by slug? what if they want to see other user
      erb :'/users/show'
    end

    get "/logout" do
      if Helpers.logged_in?(session)
        session.clear
        redirect "/login"
      else
        redirect "/login"
      end
    end


end
