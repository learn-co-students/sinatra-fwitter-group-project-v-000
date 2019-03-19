class TweetsController < ApplicationController

get '/tweets' do
  if session[:user_id] != nil
    @user = User.find_by(session[:user_id])
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  else
    redirect :"/login"
  end
end

get '/tweets/new' do
  @user = User.find_by(session[:user_id])
  if @user
    session[:user_id] = @user.id
    erb :'/tweets/new'
  else
    redirect :"/login"
  end
end

post '/tweets' do

  if session[:user_id] != nil
    @user = User.find_by(session[:user_id])
    if params[:content] == ""

      redirect :'/tweets/new'
    else
      @new_tweet = Tweet.create(params)
      @user.tweets << @new_tweet
     Tweet.create(params)
      redirect :"/tweets/#{@new_tweet.id}"
    end
  else
    redirect :"/login"
  end
end



get '/tweets/:id' do
  # binding.pry
  if session[:user_id] != nil
     @user = User.find_by(session[:user_id])
    @tweet = Tweet.find_by(params)
    erb :'tweets/show_tweet'
  else
    redirect :"/login"
  end
end

get '/tweets/:id/edit' do
  @user = User.find_by(session[:user_id])
  if @user
    @tweet = Tweet.find_by(params[:id])
    erb :"/tweets/edit_tweet"
  else
    redirect :"/login"
  end
end

patch "/tweets/:id" do

  @tweet = Tweet.find_by(params[:id])
  if params[:content] == ""
    redirect :"/tweets/#{@tweet.id}/edit"
  else
    @tweet.update(content: params[:content])
    @tweet.save
    redirect :"/tweets/#{@tweet.id}"
  end
end

delete '/tweets/:id/delete' do
  if session[:user_id] != nil
    @user = User.find_by(session[:user_id])
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user == @user
    @tweet.delete
    end
    redirect :"/tweets"
  else
    redirect :"/login"
  end
end

end
#
