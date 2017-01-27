class TweetsController < ApplicationController


  get '/' do
    erb :index
  end

  get '/tweets' do
    if !logged_in? then redirect "/login" end
    @user = current_user
    erb :"/tweets/tweets"
  end

  get '/tweets/new' do
    if !logged_in? then redirect "/login" end
    @user = current_user
    erb :"/tweets/new"
  end

  get "/tweets/:id" do
    if !logged_in? then redirect "/login" end
    @session = session
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !logged_in? then redirect "/login" end
    @tweet = Tweet.find(params[:id].to_i)
    @user = @tweet.user
    if session[:id]!= @user.id then redirect "/tweets" end
    erb :"/tweets/edit_tweet"
  end

  post '/tweets' do
    if !logged_in? then redirect "/login" end
    if params[:content] == "" then redirect "/tweets/new" end
    @tweet = current_user.tweets.create(content: params[:content])
    redirect "/tweets"
  end

  post '/tweets/:id' do
    @tweet = current_user.tweets.find_by(id: params[:id])
    @tweet.update(content: params[:content])
    if !@tweet.valid? then redirect "/tweets/#{params[:id]}/edit" end
    @tweet.save
    redirect "/tweets"
  end

  post '/tweets/:id/delete' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.user.id == session[:id] then tweet.delete end
    redirect "/tweets"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/tweets/user_profile"
  end

end
