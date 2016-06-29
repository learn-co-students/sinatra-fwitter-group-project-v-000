class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/posts'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if logged_in?
      redirect '/posts'

    elsif (!params[:username].empty? && !params[:password].empty? && !params[:email].empty?)
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      user.save
      session[:id] = user.id
      redirect "/posts"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/posts"
    else
      redirect '/'
    end
  end

  post "/login" do
    ##your code here
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/posts"
    else
        redirect "/"
    end
  end

  get "/users/:user" do
      @user = User.find_by_slug(params["user"])
      @posts = @user.posts
      erb :'posts/show_post'
  end

end
