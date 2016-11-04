class UsersController < ApplicationController 
    
    get '/signup' do
        if session[:id] == nil
          erb :'/users/signup'
        else
          redirect '/tweets'
        end
    end
    
    post '/signup' do
        @user = User.create(params)
        if @user.username.empty? || @user.password_digest == nil || @user.email.empty?
            redirect '/signup'
        else
          session[:id] = @user.id
          redirect '/tweets'
        end
    end

    get '/login' do
      if session[:id] == nil
        erb :'/users/login'
      else
        redirect '/tweets'
      end
    end
    
    post '/login' do
        if @user = User.find_by(:username => params[:username])
          if BCrypt::Password.new(@user.password_digest) == params[:password]
            # Nice!
            session[:id] = @user.id
            redirect '/tweets'
          else
            #boo
            redirect '/signup'
          end
        else
          redirect '/signup'
        end
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