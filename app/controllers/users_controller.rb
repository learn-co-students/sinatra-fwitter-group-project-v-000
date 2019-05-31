class UsersController < ApplicationController
# use Rack::Flash

   # validates_presence_of :username, :email, :password

   get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
   end



end
