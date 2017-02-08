class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      session[:id] = user.id
      redirect to '/tweets'
    else
      flash[:signup_errors] = user.errors.full_messages.join(", ")
      redirect to '/signup'
    end
  end
end
