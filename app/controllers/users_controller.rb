# class UsersController < ApplicationController
#
#   get '/users/:slug' do
#     @user = User.find_by_slug(:slug)
#     erb :'/users/show'
#   end
#
#   get '/signup' do
#     if logged_in?
#       redirect "/tweets"
#     else
#       erb :sign_up
#     end
#   end
#
#   post '/signup' do
#     if params[:username] != "" && params[:email] != "" && params[:password] != ""
#       @user = User.new(:username => params[:username])
#       @user.email = params[:email]
#       @user.password = params[:password]
#       @user.save
#       redirect '/tweets'
#     else
#       redirect '/signup'
#     end
#   end
#
#
# end
