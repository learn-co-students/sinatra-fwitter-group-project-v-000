class UsersController < ApplicationController
  get '/signup' do # route is GET request to localhost:9393/signup, where signup form is displayed
    if logged_in? # If the user is logged in, prevent user from seeing signup form; instead, redirect user to localhost:9393/tweets
      redirect to '/tweets' # user will see tweets index page
    else # otherwise, if the user is NOT logged in
      erb :'users/create_user' # render the create_user.erb view file, which is within the users/ subfolder within the views/ folder
    end
  end

  post '/signup' do # route receives POST request sent by signup form upon submission. Route receives data submitted in the signup form
    @user = User.new(username: params[:username], email: params[:email], password: params[:password] )

    if @user.save # the @user instance is successfully saved to the database if all 3 form fields are filled out (not empty string values)
      session[:user_id] = @user.id # log in the user
      redirect to '/tweets' # once user is logged in, redirect to tweets index page
    else # If any form field value is an empty string "", redirect user to localhost:9393/signup to try filling out and submitting signup form again
      redirect to '/signup'
    end
  end

  get '/login' do # route is GET request to localhost:9393/login, where login form is displayed
    if logged_in? # if the user is logged in, send them to the tweets index page
      redirect to '/tweets'
    else # otherwise, if the user is NOT logged in,
      erb :'users/login' # render the login.erb view file, which is within the users/ subfolder within the views/ folder
    end
  end

  post '/login' do # route receives POST request sent by login form upon submission. Route receives data submitted in the login form
    user = User.find_by(username: params[:username]) # find user instance by its @username attribute value
    if user && user.authenticate(params[:password]) # if user instance exists with that @username attribute value, and if the user authenticates with that password,
      session[:user_id] = user.id # log in the user
      redirect to '/tweets' # user will see tweets index page after login
    else
      redirect to '/login' # a valid username and password was not inputted in login form, so redirect to login form to try logging in again
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do # show action - route is GET request to localhost:9393/users/slugified @username attribute value of user instance
    @user = User.find_by_slug(params[:slug]) # params[:slug] is whatever replaces the :slug route variable in localhost:9393/users/:slug
    erb :'users/show' # render the show.erb view file, which is within the users/ subfolder within the views/ folder
  end

end
