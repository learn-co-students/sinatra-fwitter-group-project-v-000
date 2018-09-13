class TweetsController < ApplicationController
   
  # get '/tweets' do 
  #   @tweets = Tweet.all 
  #   erb :'tweets/tweets'
  # end   
  # get '/tweets' do
  #   if logged_in?
  #     @user = current_user
  #     @tweets = Tweet.all 
  #     erb :'tweets/tweets'
  #   else
  #     redirect 'users/login'
  #   end
  # end
     
     
  # get '/tweets' do
  #   if logged_in?
  #     @user = current_user
  #     erb :'tweets/tweets'
  #   else
  #     redirect 'users/login'
  #   end
  # end
  
#   get '/tweets/new' do
#     if !logged_in?
#       redirect 'users/login'
#     else
#       erb :"tweets/create_tweet"
#     end
#   end
  
#   post '/tweets' do
#     if logged_in?
#       new_tweet = Tweet.new(content: params[:content], user: current_user)
#     if new_tweet.save
#       redirect  '/tweets'
#     else
#       redirect  '/tweets/new'
#     end
#   end
# end
  
  
  # get '/tweets/:id' do
  #   if logged_in?
  #     @tweet = Tweet.find_by_id(params[:id])
  #     erb :'tweets/show_tweet'
  #   else
  #     redirect  '/login'
  #   end
  # end

  # get '/tweets/:id/edit' do
  #   if logged_in?
  #     @tweet = Tweet.find_by_id(params[:id])
  #     @user = current_user
  #     if @user.id == @tweet.user_id
  #       erb :'tweets/edit_tweet'
  #     else
  #       redirect  '/tweets'
  #     end
  #   else
  #     redirect  '/login'
  #   end
  # end

  # patch '/tweets/:id' do
  #   @tweet = Tweet.find_by_id(params[:id])
  #   if @tweet.update(content: params[:content])
  #     redirect  "/tweets/#{@tweet.id}"
  #   else
  #     redirect  "/tweets/#{params[:id]}/edit"
  #   end
  # end

  # delete '/tweets/:id' do
  #   @tweet = Tweet.find_by_id(params[:id])
  #   @user = current_user
  #   if @user.id == @tweet.user_id
  #     @tweet.destroy
  #     redirect  '/tweets'
  #   else
  #     redirect  '/tweets'
  #   end
  # end
end

  
 