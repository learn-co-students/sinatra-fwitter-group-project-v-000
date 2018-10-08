class UsersController < ApplicationController

    get '/users/signup' do
      erb :'/users/create_user'
    end

    post '/users/signup' do
      if params[:email] != "" && params[:email].include?("@") && params[:email].include?(".") && params[:username] != "" && params[:password] != ""
        #use method to validate email?
          user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
  		    user.save
          session[:user_id] = user.id
          redirect "/tweets"
        else
         	 redirect "/users/signup" #create failure page?...show doesn't work if not logged in
        end
    end

    get "/users/login" do
      if Helpers.logged_in?(session)
        redirect '/tweets'
      else
        erb :'users/login'
      end
    end

    post "/users/login" do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
      else
          redirect "/users/signup"
      end
    end

    get "/users/show" do
      @user = Helpers.current_user(session)
      erb :'/users/show'
    end

    get "/users/logout" do
      if Helpers.logged_in?(session)
        session.clear
        redirect "/tweets"
      else
        redirect "/users/login"
      end
    end


end
