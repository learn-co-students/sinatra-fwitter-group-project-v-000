class TweetsController < ApplicationController

  get '/tweets' do
    #binding.pry
    if is_logged_in?(session)
      @tweets = Tweet.all
      @user = current_user(session)
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      user = User.find_by(id: session[:user_id])
      tweet = Tweet.create(content: params[:content])
      user.tweets << tweet
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user == current_user(session)
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user == current_user(session)
        @tweet.destroy
        redirect '/tweets'
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
