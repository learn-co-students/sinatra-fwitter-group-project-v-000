class UsersController < ApplicationController


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'/users/show'
  end

  get '/signup' do
    if !logged_in?(session)
      erb :signup
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?(session)
      erb :login
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get "/logout" do
    if logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect '/signup'
    end
  end
end
