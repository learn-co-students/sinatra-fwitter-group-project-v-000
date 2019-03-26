class UsersController < ApplicationController

      get '/signup' do
        if !logged_in?
          erb :'/users/create_user'
        else
          redirect to '/tweets'
        end
      end

      post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          redirect to '/signup'
        else
          # binding.pry
          @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
          session[:user_id] = @user.id
          redirect to '/tweets'
       end
      end

      get '/login' do
        if !logged_in?
          erb :'/users/login'
        else
          redirect to '/tweets'
        end
      end

      post '/login' do
        @user = User.find_by(:username => params[:username])
        @user.authenticate(params[:password])
       if @user
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end

    get '/logout' do
        session.clear
        redirect to '/login'
    end

    get '/users/:slug' do
      @user = User.find_by(params[:slug])
      erb :'/user/show'
    end

end
