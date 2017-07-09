class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_users'
    end
  end

  post '/signup' do
    # binding.pry
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      flash[:message] = "Please fill all the field to sign in!!"
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  # get '/login' do
  #   erb :'/users/login'
  # end

end
