class UsersController < ApplicationController
  get '/signup' do  # signup
    erb :'/users/create_user'
  end

  post '/signup' do #user creation
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      user = User.create(params[:user_name => "username", :email => "email", :password => "password"])
      redirect to '/tweets'

    end
  end
end

# {"username"=>"skittles123", "email"=>"skittles@aol.com", "password"=>"rainbows"}
# {"user"=>
#   {"user_name"=>"picasso", "email"=>"picasso@artist.es", "password"=>"pablo"},
#  "Sign Up"=>"Submit"}

# SIGN UP
# You'll need to create two controller actions, one to display the user signup and one to process the form submission.
#  The controller action that processes the form submission should create the user and save it to the database.
# The form to sign up should be loaded via a GET request to /signup and submitted via a POST request to /signup.
# The signup action should also log the user in and add the user_id to the sessions hash.
# Make sure you add the Signup link to the home page.
