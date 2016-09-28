class UserController < ApplicationController

  get '/users/:user_slug' do
    @user = User.find_by(username: params[:user_slug])
    erb :'tweets/show_user'
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'home/signup'
  end

  post '/signup' do

    user = User.new(params[:user])

    if user.save
      user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/success' do
    erb :'home/success'
  end

end
