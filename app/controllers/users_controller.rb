class UsersController < ApplicationController
# use Rack::Flash

   # validates_presence_of :username, :email, :password

   get '/users/:slug' do
     # binding.pry
     if logged_in?
       @user = User.find_by_slug(params[:slug])
       erb :'/users/show'
     else
      redirect "/login"
    end
  end



end
