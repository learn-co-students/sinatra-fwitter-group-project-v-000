class TweetsController < ApplicationController
  
  get '/tweets' do
    if logged_in? && current_user
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to ("/login")
    end
  end

  post '/tweets' do
    if params[:content] != ""
      current_user.tweets.create(:content => params[:content])
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/new' do
    if current_user
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if current_user
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
