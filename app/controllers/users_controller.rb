class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    end
    erb :'users/signup'
  end

  post '/signup' do
    if !(params.has_value?(""))
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect 'users/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    end

    erb :'users/login'
  end

  post "/login" do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/tweets"
		end
			redirect '/login'
	end

  get "/logout" do
    if Helpers.logged_in?(session)
      session.clear

    end

    redirect "/login"
	end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'users/show'

    end
  end
end
