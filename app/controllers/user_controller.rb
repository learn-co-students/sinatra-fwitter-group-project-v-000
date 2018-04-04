class UserController < ApplicationController

   
  get '/signup' do 
    if User.is_logged_in?(session)
      redirect '/tweets'
    else
      if flash[:notice]
        flash[:notice]
      end
        erb :'users/create_user'
    end

  end 

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      @user.save 
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      flash[:notice] = "Please enter a valid username, email and password to join Fwitter!"
      redirect to '/signup'
    end 
  end
 
  get '/login' do
    if !User.current_user(session)
      erb :'users/login'
    else 
      redirect to '/tweets'
    end
  end 

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:incorrectinfo] = "The username and password you entered did not match our records. Please double-check and try again."
      erb :'users/login'
    end
  end 

  get '/logout' do
    if User.is_logged_in?(session)
     session.clear 
     redirect to '/login'
    else 
      redirect to '/'
    end
  end 

end 