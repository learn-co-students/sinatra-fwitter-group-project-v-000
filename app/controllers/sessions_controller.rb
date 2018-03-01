class SessionsController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end
  post '/login' do
    @user=User.find_by(username: params[:username])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect "/login"
  end

end
