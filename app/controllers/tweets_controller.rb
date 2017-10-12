class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find(current_user.id) #safer error throwing
      @tweets = Tweet.all
      erb :tweets
    else
      flash[:message] = "Please log in or <a href='/signup'><u>sign up</u></a> to view tweets."
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      @user = User.find(current_user.id)
      erb :new
    else
      flash[:message] = "Please log in or <a href='/signup'><u>sign up</u></a> to post tweets."
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @user = User.find(current_user.id)
      # @tweet = current_user.tweets.create(content: params[:content]) #interesting alternative
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Please don't post a blank tweet."
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :tweet
    else
      flash[:message] = "Please login/register to view this particular tweet."
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in? #if you're a member of twitter...
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      if @user.id == current_user.id
        erb :edit
      else
        flash[:message] = "Please don't edit what isn't yours."
        redirect "/tweets"
      end
    else
      flash[:message] = "Please login to edit a tweet!"
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Please don't post a blank tweet."

      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in? #if you're a member of twitter...
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      if @user.id == current_user.id
        @tweet.destroy
        flash[:message] = "The tweet has been deleted."
      else
        flash[:message] = "Please don't delete what isn't yours."
      end
    else
      flash[:message] = "Please login if you're trying to delete a tweet."
    end
    redirect "/tweets"
  end

end
