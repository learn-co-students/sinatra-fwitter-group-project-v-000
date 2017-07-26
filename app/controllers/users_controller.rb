class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    user = User.new(email: params[:email], username: params[:username], password: params[:password])
    if user && params[:username] != "" && params[:password] != "" && params[:email] != ""
        		user.save
            redirect '/tweets'
          else
            redirect '/signup'
        end
    end

    get '/login' do
      erb :'/users/login'
    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/show"
      else
        redirect "/failure"
      end
    end

    get "/logout" do
      session.clear
      redirect "/"
    end

end
