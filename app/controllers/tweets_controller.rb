class TweetsController < ApplicationController


  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to 'login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect 'tweets/new'
      else
      @tweet = Tweet.create(content: params[:content])
      current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
      end
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

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit'
      else
        redirect 'tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet= Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save

    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet && @tweet.user == current_user
        @tweet.delete
        erb :'tweets/delete'
    else
      redirect 'login'
    end
  end

end
