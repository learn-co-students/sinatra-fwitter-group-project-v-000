class TweetsController < ApplicationController

  # CREATE

  get "/tweets/new" do # (must validate session ID)
    @flash_message = session[:flash] if session[:flash]
    session[:flash] = nil
    if UserHelper.logged_in?(session)
      @flash_message = session[:flash] if session[:flash]
      session[:flash] = nil
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    @tweet = Tweet.new(params)
    @tweet.user = UserHelper.current_user(session)
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      session[:flash] = "Cannot post empty tweet"
      redirect "/tweets/new"
    end
  end

  # READ

  get "/tweets" do
    if @current_user = UserHelper.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if @current_user = UserHelper.current_user(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  # UPDATE

  get "/tweets/:id/edit" do # (must validate session ID)
    @flash_message = session[:flash] if session[:flash]
    session[:flash] = nil
    @tweet = Tweet.find(params[:id])
    @current_user = UserHelper.current_user(session)
    if @tweet.user == @current_user
      erb :'/tweets/edit'
    elsif @current_user
      redirect "/tweets"
    else
      binding.pry
      redirect "/login"
    end

  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if @tweet.update(params[:tweet])
      redirect "/tweets/#{@tweet.id}"
    else
      session[:flash] = "Cannot post empty tweet"
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  # DELETE

  delete "/tweets/:id/delete" do # (must validate session ID)
    @current_user = UserHelper.current_user(session)
    @tweet = Tweet.find(params[:id])
    if @tweet.user == @current_user
      Tweet.find(params[:id]).delete
      erb :'/tweets/delete'
    else
      redirect :'/tweets'
    end
  end

end
