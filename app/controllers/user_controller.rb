require 'pry'
class UserController < ApplicationController

  get '/signup' do
    if !loggedin?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  get '/login' do
       if !loggedin?
         erb :'/users/login'
       else
         redirect '/tweets'
       end
  end

  get '/users/:slug' do
    @user = User.find_by(username: params[:slug])
    erb :"users/show"
  end

  get '/fail' do
    erb :fail
  end

  post '/signup' do

    if session[:id] != nil

      redirect '/tweets'

    elsif params["username"] == "" || params["email"] == "" || params["password"] == ""

      redirect '/signup'

    else
        @user = User.create(username: params["user_name"], email: params["email"], password: params["password"])
        session[:id] = @user.id
        redirect '/tweets'
    end
  end

    post "/login" do
        user = User.find_by(:username => params[:username])
        if user
           if user.authenticate(params[:password]) && user.id != session[:id]
            session[:id] = user.id
            redirect "/tweets"
          end
        else
            redirect "/fail"
        end
    end


  get '/logout' do
    if loggedin?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end


end
