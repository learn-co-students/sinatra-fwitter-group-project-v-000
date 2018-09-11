class UsersController < ApplicationController

  get '/signup' do
    if !session[:id]
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

 get '/login' do
   if !session[:id]
     erb :'/users/login'
   else
     redirect '/tweets'
   end
 end

 post '/login' do
   @user = User.find_by(username: params[:username])

   if @user && @user.authenticate(params[:password])
       session[:id] = @user.id
       redirect '/tweets'
   else
       redirect '/'
   end
 end

 get '/logout' do
    if session[:id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets

    erb :"users/show"
  end



end
