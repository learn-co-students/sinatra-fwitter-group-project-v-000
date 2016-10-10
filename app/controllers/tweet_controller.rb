class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user.id
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect "/tweets/new"
    else
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.new(content: params[:content],user_id: @user.id)
      @tweet.save
      redirect "users/#{@user.username}"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id = @tweet.user.id
      if params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.content = params[:content]
        @tweet.save
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
