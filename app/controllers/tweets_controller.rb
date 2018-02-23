class TweetsController < ApplicationController

  get '/tweets' do
    verify_user
    @tweets = Tweet.all
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    verify_user
    erb :"/tweets/create_tweet"
  end


  get '/tweets/:id' do
    verify_user
    @tweet = Tweet.find_by_id(params[:id])

    erb :"/tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    verify_user
    @tweet = Tweet.find_by_id(params[:id])

    erb :"/tweets/edit_tweet"
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = Tweet.new(params)
      verify_user
      @tweet.user_id = @current_user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      verify_user
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect to "/tweets"
    end
  end

end
