class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug params[:slug]
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.new params
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = @user.errors.full_messages.uniq
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by email: params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = ["Incorrect email/password match, please try again."]
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
