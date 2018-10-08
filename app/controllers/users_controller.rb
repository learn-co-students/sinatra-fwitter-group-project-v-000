class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :"/users/create_user"
  end
  
  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end
    
    erb :"/users/login"
  end
  
  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
    end
    
    redirect "/login"
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
  post '/signup' do
    params.each do |label, input|
      if input.empty?
        redirect to "/signup"
      end
    end

    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = user.id

    redirect to "/tweets"
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

end
