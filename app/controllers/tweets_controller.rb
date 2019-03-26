class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find_by(:username => params[:username])
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/tweets'
    end
   end

   get '/tweets/new' do
     @user = User.find_by(params[:username])
     if logged_in?
       erb :'/tweets/new'
     else
       redirect to '/login'
   end
 end

   post '/tweets' do
     if params[:content].empty?
       redirect to '/tweets/new'
      else
       @tweet = Tweet.create(:content => params[:content])
       @user = User.find_by(params[:username])
       @tweet.user_id = @user.id
       @tweet.save
       erb :'/tweets/show_tweet'
     end
   end

   get '/tweets/:id' do
     if !logged_in?
       redirect to '/login'
     else
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    elsif logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/edit_tweet'
      # binding.pry
    end
  end

   patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
     if params[:content].empty?
       redirect to "/tweets/#{@tweet.id}/edit"
      else
       @tweet.content = params[:content]
       @tweet.save
       redirect to "/tweets/#{@tweet.id}"
     end
   end

    delete '/tweets/:id/delete' do #delete action
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    end


end
