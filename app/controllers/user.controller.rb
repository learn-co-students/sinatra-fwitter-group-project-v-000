class UserController < ApplicationController

  get '/users/:slug' do 
    @user = User.find_by(name: User.unslug(params[:slug]))
    erb :'users/show'
  end

  get '/signup' do 
    if !session[:id]
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do     
   
    @user = User.new(params[:user])

    if @user.save
      session[:id] = @user.id 
      redirect '/tweets'

    elsif 
      redirect '/signup'
    end
  end

  get '/login' do 
    if !session[:id]
      erb :'users/login'
    else 
      redirect '/tweets'
    end
  end

  
  post '/login' do 
    user = User.find_by(:username => params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end

  end


  get '/logout' do
    if session[:id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end