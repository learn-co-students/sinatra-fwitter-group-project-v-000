class TweetsController < ApplicationController

  get '/tweets' do
   if logged_in?
     @tweets = Tweet.all
     erb :'tweets/tweets'
   else
     redirect to '/login'
   end
 end

 get '/tweets/new' do
   if logged_in?
     erb :'tweets/create_tweet'
   else
     redirect to '/login'
   end
 end

 post '/tweets' do
   if logged_in?
     if params[:content] == ""
       redirect to "/tweets/new"
     else
       @user = User.find_by(id: session[:user_id])
       @tweet = Tweet.create(content: params[:content], user_id: @user.id)
       @tweet.save
       redirect to "/tweets/#{@tweet.id}"
     end
   else
     redirect to '/login'
   end
 end

 get '/tweets/:id' do
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
    #  binding.pry
     erb :'/tweets/show_tweet'
   else
     redirect to '/login'
   end
 end

 get '/tweets/:id/edit' do
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     if @tweet && @tweet.user == current_user
       erb :'tweets/edit_tweet'
     else
       redirect to '/tweets'
     end
   else
     redirect to '/login'
   end
 end

 patch '/tweets/:id' do
   @tweet = Tweet.find(params[:id])
   @user = User.find_by(id: session[:user_id])
   if logged_in?
     if !params[:content].empty? && @tweet.user_id == @user.id
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    elsif params[:content].empty? && @tweet.user_id == @user.id
      redirect to("/tweets/#{@tweet.id}/edit")
    elsif !params[:content].empty? && @tweet.user_id != @user.id
      redirect to("/tweets")
    end
  end
 end

 delete '/tweets/:id/delete' do
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     if @tweet && @tweet.user == current_user
       @tweet.destroy
       redirect to '/tweets'
     end
   else
     redirect to '/login'
   end
 end

end
