class UserController < ApplicationController

    get '/signup' do
      if logged_in
        redirect to "/tweets"
      else
        erb :'users/create_user'
      end

    end

    post '/signup' do

      if params["username"] == ""
        redirect to "/signup"
      elsif params["email"] == ""
        redirect to "/signup"
      elsif params["password"] == ""
        redirect to "/signup"
      else
        @user = User.new
        @user.email = params["email"]
        @user.username = params["username"]
        @user.password_digest = params["password"]
        @user.save
        session[:user_id] = @user.id
        redirect to "/tweets" #goes to GET route '/tweets'
      end #if statement
    end #POST route

    get '/login' do
      if logged_in
        redirect to "/tweets"
      else
        erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params["username"])

      if @user
          session[:user_id] = @user.id
          redirect to "/tweets"  #goes to GET route '/tweets'
      else
          redirect to "/login"
      end
    end


    get '/tweets' do

      @user = User.find_by(id: session["user_id"])

      if logged_in
        redirect to "tweets/tweets" #FIX
      else
        redirect to "users/login"
      end
    end

    get '/logout' do
      @user = User.find_by(id: session["user_id"])
      if @user
        session.clear
        redirect to "users/login"
      else
        redirect to "/"
      end
    end

end
