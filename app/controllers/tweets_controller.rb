class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end


  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
  if params[:content] == ""
    redirect "/tweets/#{params[:id]}/edit"
  else
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end
end

delete '/tweets/:id/delete' do
  @tweet = Tweet.find(params[:id])
  if @tweet.user_id == current_user.id
    @tweet.delete
    redirect '/tweets'
  else
    redirect '/login'
  end
end




end
