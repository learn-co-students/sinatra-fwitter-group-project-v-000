class UsersController < ApplicationController
  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
  end
  # display the user signup
  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: 'Please sign up first'}
    else
      redirect to '/tweets'
    end
  end
  # process the form submission of user signup
  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:email => params[:email], :username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end
  # display the form to log in
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end
  # log add the `user_id` to the sessions hash
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
# logout the user
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
