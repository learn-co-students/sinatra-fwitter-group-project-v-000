class UsersController < ApplicationController

    get '/signup' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
          if user.id == session[:user_id]
            redirect to '/tweets'
          end
        else
          erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:confirm_password] == ""
            redirect to '/signup'
        else
            user = User.create(username: params[:username], password: params[:password], email: params[:email])
            session[:user_id] = user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
          if user.id == session[:user_id]
            redirect to '/tweets'
          end
        else
          erb :'/users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(:username => params[:username])
 
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
        else
          redirect "/login"
        end
    end

    get '/logout' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
          if user.id == session[:user_id]
            erb :'/users/logout'
          end
        else
          erb :'/'
        end
    end

    post '/logout' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
          if user.id == session[:user_id]
            session[:user_id] = ""
            redirect to '/login'
          end
        else
          erb :'/users/login'
        end
    end

end