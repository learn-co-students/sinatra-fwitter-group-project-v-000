class UsersController < ApplicationController
  
 get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/user/show'
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'/users/create_user'
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect :'/tweets'
    end
  end
  
  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
      erb :'/users/login'
  end

    post '/login' do
      @user = User.find_by(:username => params[:username])
       if @user && @user.authenticate(params[:password])
          session[:id] = @user.id
          redirect :'/tweets'
        else
          redirect to '/signup'
       end
    end

    get '/logout' do
      if logged_in?
          session.clear
          redirect to '/login'
      else
        redirect to '/'
      end
    end
    

end
