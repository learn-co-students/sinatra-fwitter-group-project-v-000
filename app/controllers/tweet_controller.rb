class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user.id
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if current_user.tweets.create(content: params[:content]).invalid?
      redirect "/tweets/new"
    else
      redirect "/users/#{current_user.username}"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id = @tweet.user.id
      if params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.user.id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end
end
