class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #raise params.inspect
      session[:user_id] = @user.id # actually logging the user in
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    #binding.pry
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      # create a new user
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"

    else
      redirect '/signup'
    end
  end

  # user SHOW route
# this routes job is to show the user
get '/users/:slug' do # this will be the user show route
  # what do I need to do first?
  # raise params.inspect
  @user = User.find_by_slug(params[:slug])
#binding.pry
#  redirect_if_not_logged_in
  erb :'users/show'
end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
