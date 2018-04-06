class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end 

  # Create ----------------------------------------------------------------

  get '/tweets/new' do
    logged_in? ? (erb :'tweets/create_tweet') : (redirect to '/login')
  end 

  post '/tweets' do
    if params[:content].empty?
      flash[:message] ="Provide some content to post a tweet!"
      redirect to '/tweets/new'
    elsif logged_in?
      @user = current_user
      @tweet =Tweet.create(params)
      @user.tweets << @tweet
      redirect to "tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end 
  end

  # Read ----------------------------------------------------------------------

  get '/tweets/:id' do
    redirect to '/login' if !logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
    # if logged_in? 
    #   @tweet = Tweet.find_by_id(params[:id])
    #   erb :'tweets/show_tweet'
    # else 
    #   redirect '/login'
    # end 
  end 

  # Update ---------------------------------------------------------------------

  get '/tweets/:id/edit' do 
    redirect to '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user != current_user
      flash[:notice] = "You cannot change another user's content, silly"
      redirect to "/tweets/#{@tweet.id}"
    end
      erb :'tweets/edit_tweet'
  end 

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet.update(content: params[:content])
    redirect to "/tweets/#{@tweet.id}"
  end 

  # Delete -----------------------------------------------------------------------

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.delete 
      redirect to "/tweets"
    else 
      flash[:notice] = "You cannot change another user's content, silly."
      redirect to "/tweets/#{@tweet.id}"
    end 
  end 

end