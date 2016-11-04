class UsersController < ApplicationController 
    
    get '/signup' do
        if session[:id] == nil
          "test"
        else
          redirect '/tweets'
        end
    end
    
    post '/signup' do
        @user = User.create(params)
        if @user.username.empty? || @user.password.empty? || @user.email.empty?
            redirect '/signup'
        else
          session[:id] = @user.id
          redirect '/tweets'
        end
    end
    
    get '/login' do
      if session[:id] == nil
        erb :'/users/signup'
      else
        redirect '/tweets'
      end
    end
    
    post '/login' do
        @user = User.find_by(:username => params[:username], :password => params[:password])
        session[:id] = @user.id
        redirect '/tweets'
    end
    
    get '/logout' do 
        session.clear
        redirect '/login'
    end
    
    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end
    
end