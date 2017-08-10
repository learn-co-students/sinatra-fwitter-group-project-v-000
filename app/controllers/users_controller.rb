class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(:slug)
    erb :'/users/show'
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post "/signup" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

    if !params[:username].empty? && !params[:email].empty? && @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end
end
