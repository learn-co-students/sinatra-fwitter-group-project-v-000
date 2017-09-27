class UsersController < ApplicationController

  get '/signup' do
    logged_in? ? (redirect '/tweets') : (erb :'users/create_user')
  end

  post '/signup' do
    if  params[:username].empty? || params[:email].empty? ||
        params[:password].empty?
     
     redirect '/signup'
    else
      user = User.create(username: params[:username], email: params[:email],
             password: params[:password])

      session[:user_id] = user.id
      session[:welcome] = "Thanks for Signing Up! Enjoy Learns' " \
                              "Programmer Media! =D "
      redirect '/tweets'
    end
  end

  get '/login' do
    logged_in? ? (redirect '/tweets') : (erb :'users/login')
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:welcome] = "Welcome Back! <3"
      
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])

    erb :'users/show'
  end

  get '/logout' do
    logged_in? ? session.clear && (redirect '/login') : (redirect '/')
  end

end
