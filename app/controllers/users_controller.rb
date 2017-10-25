class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
     erb :'users/create_user'
    end
   end

   post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:id] = @user.id
        redirect to '/tweets'
     end
   end

   get '/login' do
     if logged_in?
      redirect '/tweets'
     else
      erb :'users/login'
     end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
   if user &&   user.authenticate(params[:password])
   session[:id] = user.id
   redirect "/tweets"
    else
     redirect to "/signup"
     end
   end

   get '/logout' do
    if logged_in? != nil
     session.clear
     redirect '/login'
    else
     redirect to '/'
     end
   end

   get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
     erb :'users/show'
   end

end
