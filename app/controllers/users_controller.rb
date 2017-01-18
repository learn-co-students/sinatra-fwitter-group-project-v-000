class UsersController < ApplicationController
  get '/signup' do  # signup
    erb :'/users/create_user'
  end

  post '/signup' do #user creation
    binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.new(params[:username => "username", :email => "email", :password => "password"])
      binding.pry
      @user.save
      binding.pry
      session[:user_id] = @user.id
      redirect to '/tweets'

    end
  end
end

# {"username"=>"skittles123", "email"=>"skittles@aol.com", "password"=>"rainbows"}
# The signup action should also log the user in and add the user_id to the sessions hash.
