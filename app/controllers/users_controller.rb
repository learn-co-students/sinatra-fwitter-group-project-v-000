class UsersController < ApplicationController

# get '/login' do
#     if logged_in?
#       redirect to '/tweets'
#     else
#       erb :'users/login'
#     end
#   end
  
  # post "/login" do
  # user = User.find_by(username: params[:username])
 
  # if user && user.authenticate(params[:password])
  #   session[:user_id] = user.id
  #   redirect "/tweets"
  # else
  #   redirect "/login"
  # end
  # end
  
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    redirect "/users/show"
  end
  
  
end

