class UsersController < ApplicationController


    get '/users/show' do
      if session[:user_id]
        # session[:user_id] = @user.id
        @tweets = Tweet.all
        @user = User.find_by_id(session[:user_id])
         @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
        erb :'users/show'
      else
        redirect to 'users/login'
      end
    end


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
 # @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
   if !session[:user_id]
     erb :'users/signup'
   else

     redirect '/tweets'
 end
end

  post '/signup' do
    # if params[:username] =="" || params[:password] ==""|| params[:email] ==""
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'

    else
   @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
   @user.save
   session[:user_id] = @user.id

   redirect '/tweets'
 end
end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/users/show' do
    if session[:user_id]
      # session[:user_id] = @user.id
      @tweets = Tweet.all
      @user = User.find_by_id(session[:user_id])
       @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      erb :'users/show'
    else
      redirect to 'users/login'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
  else
  redirect to '/'
   end
end

  end
