class UserController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      erb :'users/create_user', locals: { message: "Please sign up before you sign in..." }
    else
      redirect to 'users/show'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
    	@user = User.new(name: => params[:username], email: => params[:email], password: => params[:password])
      @user.save
      session[:user_id] = @user.id
      erb :'users/show'
    end
  end

end
