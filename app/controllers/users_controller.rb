class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    @user = User.find_or_initialize_by(username: params[:username], email: params[:email])
    @user.password = params[:password]

    if !!@user && @user.save
      session[:user_id]=@user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/users/:slug' do
    #if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"users/show"
    # else
    #   redirect "/login"
    # end
  end


end
