class UsersController < ApplicationController
    
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    end

    get '/' do
      erb :'/index'
    end
    
    #loads the signup page
    #see User Authentication in Sinatra lab
    get '/signup' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'/users/create_user'
      end
    end
    
    #see User Authentication in Sinatra lab
    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id #user is logged in
        redirect to '/tweets'
      end
    end

    get '/login' do
      if !logged_in?
        erb :'/users/login'
      else
        redirect '/tweets'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id #user logged in
        redirect '/tweets'
      else
        redirect '/signup'
      end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect '/login'
      else
        redirect '/'
      end
    end

    

end
