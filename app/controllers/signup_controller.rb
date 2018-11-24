class SignupController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/signup'
    end

  end

  post '/signup' do 
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      redirect "/signup"
    elsif user.save
      session[:user_id] = user.id
      redirect "/tweets" 
    else
      redirect "/failure"
    end
  end
end
