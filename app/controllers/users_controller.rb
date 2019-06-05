class UsersController < ApplicationController

 get '/signup' do
   erb :'/users/new'
 end

 post '/signup' do
   @user = User.create(params)
   binding.pry
 end
end
