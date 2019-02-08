class UsersController < ApplicationController
  # Could use flash messages throughout this controller with each redirect.

  get '/signup' do
    redirect "/tweets" if logged_in?
      # If the user is already logged in, they'll automatically be redirected to the Tweets page.
    erb :'users/create_user'
  end

  post '/signup' do
    # Should do username and email validation here.
    params.each_value {|v| redirect "/signup" if v.empty?}
      # Making sure none of the signup credentials were left blank.
    user = User.create(params)
      # Creating the new user.
    session[:user_id] = user.id
      # Logging the user in.
    redirect "/tweets"
  end

  get '/login' do
    redirect "/tweets" if logged_in?
      # If the user is already logged in, they'll automatically be redirected to the Tweets page.
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
      # Finding the user in the database by the username entered in the login form.
    if user && user.authenticate(params[:password])
        # If the user exists in our database and their entered password matches 
        # the password saved in our database...
      session[:user_id] = user.id
        # We log the user in.
      redirect "/tweets"
		else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear if logged_in?
      # If the user is logged in, we log them out by clearing their browsing session.
    redirect "/login"
  end

  get '/users/:slug' do
    erb :'users/show'
  end

end
