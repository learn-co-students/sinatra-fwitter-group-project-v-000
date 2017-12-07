class UserController < ApplicationController

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :'/users/create_user'
	end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'/users/login'
	end

	post '/signup' do
		if params.none? { |k, v| v.blank? }
      user = User.create(email: params[:email], username: params[:username], password: params[:password])
      user.save
      session[:user_id] = user.id
  		redirect '/tweets'
    else
      redirect '/signup'
		end
	end

	post '/login' do
    redirect '/tweets' if logged_in?
		user = User.find_by(username: params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/tweets'
		else
			erb :'users/login'
		end
	end

  get '/logout' do
    logout! if logged_in?
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'user/show'
  end
end
