class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
		user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      sign_in(user)
			redirect "/tweets"
		else
			redirect "/signup"
		end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :show
  end
end