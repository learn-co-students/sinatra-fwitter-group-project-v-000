class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'/users/signup'
      end
    end

    post '/signup' do
      if params[:email] == "" || params[:username] == "" || params[:password] == ""
        redirect to '/signup'
      end
      @user = User.create(:email => params[:email], :username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

    get '/login' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        # @session = session
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/tweets'
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end

end
