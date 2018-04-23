class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
    	 redirect '/tweets'
    	else
    	 erb :"users/signup"
    	end
    end

    post '/signup' do
      @user = User.new(params)
    	if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      end
        if @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
      end
    end

    get '/users/:slug' do
      @user = current_user
      erb :'users/show'
    end

    get '/login' do
      if logged_in?
       redirect '/tweets'
      else
       erb :'users/login'
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/'
        end
      end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end


end
