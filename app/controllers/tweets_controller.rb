class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
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

  post '/tweets' do
    if logged_in?
      if params[:content] !=""
        @user = current_user
        @tweet = @user.tweets.build(content: params[:content])
        @user.save

        redirect  "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do

    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet= Tweet.find(params[:id])
    if logged_in? && !params[:content].blank?
      @tweet.update(content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end

end
