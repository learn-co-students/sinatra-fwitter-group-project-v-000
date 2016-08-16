class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

 get '/signup' do 
    if !is_logged_in?
      erb :'users/create_user'
    else 
      redirect "/tweets"
    end 
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else 
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save

      session[:user_id] = @user.id

      redirect to '/tweets'
  end  
  end

  get '/login' do 
    if is_logged_in?
      redirect '/tweets'
    else 
      erb :'users/login'
    end
  end

  post '/login' do
    if user = User.find_by(:username => params["username"])
      if user.authenticate(params["password"])
        session[:user_id] = user.id
        redirect '/tweets'
      else 
        redirect '/signup'
      end  
    end
  end


  get '/logout' do 
    if is_logged_in?
      logout!
      redirect to '/login'
    else 
      redirect '/'
    end 
  end



end