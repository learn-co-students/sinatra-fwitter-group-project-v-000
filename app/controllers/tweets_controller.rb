class TweetsController < ApplicationController

  get "/tweets/new" do
    if !!session[:id]
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content].empty?
      redirect :"tweets/new"
    else
      @tweet = Tweet.create(params)
      @tweet.user_id = User.find(session[:id]).id
      @tweet.save
      redirect "/tweets"
    end
  end

  get "/tweets/:id/edit" do
    if self.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if self.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end


  patch "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]   # change name/whatever according to params
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "tweets/#{@tweet.id}/edit"
    end
  end

  post "/tweets/:id/delete" do
    @tweet = Tweet.find_by(id: params[:id])
    if self.is_logged_in?(session) && self.current_user(session).id == @tweet.user_id
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "tweets"
    end
  end


end
