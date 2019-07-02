class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && !params[:content].empty?
      @user = User.find_by_id(session[:user_id])
      @tweet = current_user.tweets.build(content: params[:content])

      @tweet.save

      redirect to "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :"tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if !params[:content].empty?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect '/tweets'
        end
      else
        redirect to "/tweets/#{params[:id]}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
