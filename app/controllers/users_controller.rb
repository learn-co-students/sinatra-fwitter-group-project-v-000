class UsersController < ApplicationController

get '/signup' do
  if session["user_id"] == nil
    erb :'/users/create_user'
  else
    redirect '/tweets'
  end
end

get '/users/show' do
@user = User.find(session[:user_id])

  erb :'/users/show'
end

get '/login' do
  if session["user_id"] == nil
  erb :'/users/login'
else
  redirect "/tweets"
end
end

get '/logout' do
  if session["user_id"] != nil
  session.clear
  redirect '/login'
  else
    redirect '/login'
  end
end

post '/signup' do
if params[:username] != "" && params[:email] != ""
  user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  else
    redirect "/signup"
  end
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

get '/users/:slug' do
@user = User.find_by_slug(params[:slug])

  erb :'/users/show'
end




end
