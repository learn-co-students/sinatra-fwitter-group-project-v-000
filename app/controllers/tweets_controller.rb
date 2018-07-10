class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets" do

    if logged_in?
      if params[:content] == ""
        redirect "/tweets/new"
      else
        @tweet = Tweet.new(content: params[:content])
        @tweet.user_id = current_user.id

        if @tweet.save
          #flash[:success] = "Tweet Successfully Created"
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/new"
        end #@tweet.save
      end #params[:content]

    else
      redirect "/login"
    end #logged_in?
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end

    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id/edit" do
    if logged_in?
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by(id: params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets"
      end

    else
      redirect "/login"
    end
  end

end
