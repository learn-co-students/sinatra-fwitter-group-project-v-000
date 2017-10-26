class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all

    if logged_in? #accessing tweets index with welcoming message only if user is logged in
      @user = current_user #needed to welcoming message
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in? #use can only create tweet if logged in
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty? #only non-empty fweets can be saved
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id]) #fweet needs to have user_id to be linked to user instance
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?   #users can only access own tweets
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && @tweet.user == current_user #users can only edit own tweets
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?  #users can't save an empty fweet in the edit action
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && @tweet.user == current_user #users can only delete own fweets
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
