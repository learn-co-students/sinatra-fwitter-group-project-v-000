
class UsersController < ApplicationController

use Rack::Flash



get '/signup' do 
  if logged_in?
    redirect '/tweets'
  else
  erb :'users/create_user'
  end
end

post "/signup" do 
  user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:message] = "Please enter an email, username and password to create an account. "
      redirect to "/signup"
    end
end


get '/login' do
  if logged_in?
    redirect '/tweets'
  else
  erb :'users/login'
  end
end

post "/login" do
  #raise params.inspect
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/tweets'
  else
    flash[:message] = "Sorry, there was a problem logging in. Please try again."
    redirect to '/login'
  end
end

get '/logout' do
  if logged_in?
    session.destroy
    redirect "/login"
  else
    redirect "/"
  end
end

get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'/users/show'
end


end