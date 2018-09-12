class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

 get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :"/tweets/create_tweet"
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/new'
    end
    @tweet = Tweet.new(content: params[:content])
    @tweet.user_id = current_user.id
    @tweet.save

    redirect to "/tweets"
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
			redirect to "/login"
		else
			@tweet = Tweet.find_by(params[:id])
			if @tweet && @tweet.user == current_user
        @tweet.destroy
        redirect to "/tweets"
      else
        redirect to "/login"
      end
    end
  end

end
