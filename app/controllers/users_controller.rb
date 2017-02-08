class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/'
    else
      erb :'users/signup'
    end
  end

  post '/users' do
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect to '/'
    else
      flash[:signup_errors] = user.errors.full_messages.join(", ")
      redirect to '/signup'
    end
  end
end
