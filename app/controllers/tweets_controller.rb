class TweetsController < ApplicationController

  get '/tweets' do
    if self.logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if self.logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = self.current_user

    tweet = Tweet.create(params)
    tweet.user = @user
    if tweet.save
      redirect '/tweets'
    else
      redirect to('/tweets/new')
    end
  end

  get '/tweets/:id' do
    if self.logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if self.logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    if @tweet.save
      redirect to("/tweets/#{@tweet.id}")
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == self.current_user
      @tweet.destroy
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

end
