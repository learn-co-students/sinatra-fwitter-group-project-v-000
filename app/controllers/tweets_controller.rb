class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      	@users = User.all
      	@user = current_user
      	@tweets = Tweet.all
      	erb :'/tweets/show'
    else
      	redirect '/login'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

 post '/tweets' do
   	if logged_in? && !params[:content].empty?
        @user = current_user
        @user.tweets.create(content:params[:content])
        redirect "/users/#{@user.slug}"
   	elsif logged_in? && params[:content].empty?
        redirect "/tweets/new"
    else
        redirect "/login"
    end
end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user != ""
      erb :'/tweets/user_all_tweets'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
     	 @tweet = Tweet.find(params[:id])
      	 erb :'/tweets/show_tweet'
    else
       	 redirect '/login'
    end
  end

get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    end
  end

patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

delete '/tweets/:id/delete' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
      end
      redirect '/tweets'
    end
  end

end