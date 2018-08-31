class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
        @tweet = current_user.tweets.build(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
    erb :'/tweets/show_tweet'
  else
    redirect '/login'
  end
end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && @tweet.content != ""
        erb :'/tweets/edit_tweet'
    else
        redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      @tweet.save
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end


  delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
      end
    end
  end



end
