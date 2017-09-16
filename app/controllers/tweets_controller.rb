class TweetsController < ApplicationController

  get "/tweets" do
    @tweets = Tweet.all
    if logged_in?
      erb :"tweets/tweets"
    else
    redirect to "/login"
    end
  end


  get "/tweets/new" do
    if logged_in?
    erb :"tweets/create_tweet"
  else
    redirect to "/login"
  end
end

  post "/tweets" do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content])
    # binding.pry
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
    end
 end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(session[:user_id])
      erb :"tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(session[:user_id])
      erb :"tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  post "/tweets/:id" do
    if logged_in?
     @tweet = Tweet.find_by_id(session[:user_id])
     @tweet.content = params[:content]
     @tweet.user_id = session[:user_id]
     @tweet.save
     redirect "/tweets/#{@tweet.id}/edit"
   else
     redirect to "/login"
  end
end


  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end





end
