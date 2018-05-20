class TweetController < ApplicationController

  get '/tweets' do
    go_log_in
    @user = current_user
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    go_log_in
    @user = current_user
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    redirect :"/tweets/new" if params["content"] == ""
    @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])

    flash[:message] = "Successfully created Tweet."

    redirect :"/tweets"
  end

  get '/tweets/:id' do
    go_log_in
    @tweet = current_tweet
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    go_log_in
    @tweet = current_tweet
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    redirect :"/tweets/#{params[:id]}/edit" if params["content"] == ""
    @tweet = current_tweet
    @tweet.update(content: params[:content])
    @tweet.save

    flash[:message] = "Successfully updated Tweet."

    redirect "/tweets"
  end

  delete '/tweets/:id/delete' do
    go_log_in
    @tweet = current_tweet
    @tweet = Tweet.find(params[:id])
    redirect "/tweets" if session[:user_id] != @tweet.user_id
    @tweet.delete

    flash[:message] = "Successfully deleted Tweet."

    redirect "/tweets"
  end

end
