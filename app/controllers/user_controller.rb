require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

    get '/signup' do
#binding.pry
         erb :"/users/create_user"
    end


    post '/signup' do

          if params[:user][:name]=="" || params[:user][:email]=="" || params[:user][:password]==""
               flash[:message] = "Do not leave Username/Email/Password sections blank."
                redirect to '/signup'
          elsif  !!User.find_by(username: params[:user][:name])
                flash[:message] = "This username has already been taken. Please makeup a new username."
                 redirect to '/signup'
         elsif  !!User.find_by(email: params[:user][:email])
                 flash[:message] = "This email has already been taken. Please use a new email."
                redirect to '/signup'
          else

              @user = User.create(username: params[:user][:name], email: params[:user][:email], password_digest: params[:user][:password])
              session[:user_id] = @user.id
binding.pry
              redirect to '/tweets'
          end

    end


end


#SIGN UP
#      You'll need to create two controller actions, one to display the user signup and one to process the form submission. The controller action that processes the form submission should create the user and save it to the database.
#      The form to sign up should be loaded via a GET request to /signup and submitted via a POST request to /signup.
#  #   The signup action should also log the user in and add the user_id to the sessions hash.
#      Make sure you add the Signup link to the home page.

# =>        rspec spec/controllers/application_controller_spec.rb
