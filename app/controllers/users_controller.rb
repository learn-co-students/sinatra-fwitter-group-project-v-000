class UsersController < ApplicationController

  get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     erb :'/users/index'
   end
  # Create route for users/slug here
  # Find the user by slug
  # render the users/show and show the tweets
  # Hint: https://github.com/MarielJHoepelman/playlister-sinatra-v-000/blob/master/app/models/song.rb

end
