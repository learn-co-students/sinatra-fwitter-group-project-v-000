class TweetsController < ApplicationController

  get '/tweets' do
    #if logged_in?
    if session[:user_id]
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    #@user = current_user
    #if !params[:content].empty?
    #  @tweet = Tweet.create(params)
    #  @tweet.user = @user
    #  redirect "/tweets"
    #else
    #  redirect "/tweets/new"
    #end

    user = User.find_by_id(session[:user_id])
      if !params[:content].empty?
        @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end
    #if logged_in?
    #  @user = current_user
    #  @user.tweets << Tweet.create(:content => params[:content]) unless params[:content].empty?
    #end
  end

  get "/tweets/:id" do
    if logged_in?
    #if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
    #if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    #@tweet = Tweet.find_by_id(params[:id])
    #@tweet.content = params[:content]
    #@tweet.save
    #redirect to "/tweets/#{@tweet.id}"

    if logged_in?
      @tweet = Tweet.find(params[:id])
      if !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end


  end

  delete "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

end
