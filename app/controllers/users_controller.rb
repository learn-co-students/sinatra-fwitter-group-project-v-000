class UsersController < ApplicationController
    
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
    end

    get '/' do
      erb :'/index'
    end
    
    #loads the signup page
    #see User Authentication in Sinatra lab
    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
      else
        redirect '/tweets'
      end
    end
    
    #see User Authentication in Sinatra lab
    post '/signup' do
      if !params[:username].empty? && !params[:email].emptyd? && !params[:password].empty?
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        #binding.pry
        session[:user_id] = @user.id #user is logged in
        redirect '/tweets'
      else
        redirect to '/signup'
      end
    end

    get '/login' do
      if !logged_in?
        erb :'/users/login'
      else
        redirect 'tweets'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id #user logged in
        redirect '/tweets'
      else
        redirect '/login'
      end
    end


end
