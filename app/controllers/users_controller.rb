class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    session[:user_id] = @user.id
    erb :'/tweets'
  end

  get '/signup' do
    if session[:user_id].to_s.empty?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end


  post '/login' do
  @user = User.find_by(:username => params[:username])
    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/'
    end
  end

end
