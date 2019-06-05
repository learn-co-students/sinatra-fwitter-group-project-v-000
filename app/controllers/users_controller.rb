class UsersController < ApplicationController

 get '/users/signup' do
   erb :'/users/new'
 end
end
