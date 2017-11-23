class TweetController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @user = current_user
      erb :'tweet/show'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    redirect back if params[:content] == ""
    @tweet = current_user.tweets.create(content: params[:content])
    redirect '/tweets'
  end

  get '/tweets/new' do
    if is_logged_in?
      @user = current_user
      erb :'tweet/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweet/single'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content] == ""

    if is_logged_in?
      if @tweet.user_id == current_user.id
        @tweet.update(content: params[:content])
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweet/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}"
    end
  end

end
