class UsersController < ApplicationController
<<<<<<< HEAD
   get "/users/:slug" do
     @user = User.find_by_slug(params[:slug])
     erb :'/users/show'
   end
=======
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



>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
end
