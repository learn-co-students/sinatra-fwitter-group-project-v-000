# class TweetsController < ApplicationController
#
#   get '/tweets' do
#     if !logged_in?
#       redirect '/login'
#     else
#       @user = current_user
#       erb :'/tweets/tweets'
#   end
# end
#
#   get '/tweets/new' do
#     erb :'/tweets/create_tweet'
#   end
#
#   post '/tweets/new' do
#     @tweet = Tweet.new(content: params[:content])
#     @tweet.save
#     #@tweet.user_id = Signed in user
#
#     erb :"/tweets/show"
#   end
#
#   get '/tweets/:id' do
#     @tweet = Tweet.find(params[:id])
#
#     erb :'/tweets/show'
#   end
#
#   get '/tweets/:id/edit' do
#       @tweet = Tweet.find(params[:id])
#
#       erb :'/tweets/edit'
#   end
#
#   patch '/tweets/:id' do
#       @tweet = Tweet.find(params[:id])
#       @tweet.content = params[:content]
#       @tweet.save
#
#       redirect to "/tweets/#{@tweet.id}"
#   end
#
#   delete '/tweets/:id/delete' do
#     if logged_in?
#       @tweet = Tweet.find(params[:id])
#       @tweet.delete
#       redirect to "/"
#     else
#       redirect "/login"
#     end
#   end
#
#     get '/show' do
#       erb :show
#     end
#
# end
