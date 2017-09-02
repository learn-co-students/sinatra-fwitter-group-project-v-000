# class SessionController < ApplicationController
#
#   get '/login' do
#     if logged_in?
#       redirect '/tweets'
#     else
#       erb :login_in
#     end
#   end
#
#   post '/login' do
#     @user = User.find_by(:email => params[:email])
#
#       if @user && @user.authenticate(params[:password])
#           session[:user_id] = @user.id
#           redirect '/tweets'
#       else
#           redirect '/login'
#       end
#   end
#
#   get '/logout' do
#     if logged_in?
#       session.clear
#       redirect "/login"
#     else
#       redirect "/"
#     end
#   end
#
# end
