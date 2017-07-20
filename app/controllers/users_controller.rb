class UsersController < ApplicationController

    get '/' do

        erb :"/homepage"
    end
    
  get '/signup' do
    if !logged_in?
      erb :"/signup"
      else
         redirect to "/tweets"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
    
      redirect to "/signup"
      else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
    redirect to "/tweets"
    end
  end

  get '/login' do
        if !logged_in?
           erb :"/sessions/login"
        else
            redirect to "/tweets"
        end
    end

    post '/login' do
        @users = User.find_by(:username => params[:username])
                session[:user_id] = @users.id
        redirect to "/tweets"
        
        
    end

    get '/tweets' do
        if logged_in?
        erb :'/tweets'
        else
        redirect to "/login"
        end
    end

    get '/logout' do
        if logged_in?
        session.clear
        redirect to "/sessions/login"
        else
        redirect to "/"
        end
        
    end
    

end

