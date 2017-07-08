class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if session[:user_id]
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

end
