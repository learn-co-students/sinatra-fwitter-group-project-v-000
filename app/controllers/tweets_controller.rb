class TweetsController < ApplicationController
  get "/tweets" do
      if Helpers.is_logged_in?(session)
        erb :"tweets/index"
      else
        redirect "/login"
      end
  end
    get "/tweets/new" do
      if Helpers.is_logged_in?(session)
        erb :"tweets/new"
      else
        redirect "/login"
      end
    end
     post "/tweets" do
      tweet = Tweet.new(content: params[:content])
      tweet.user = Helpers.current_user(session)
      if tweet.save
        redirect "/tweets"
      else
        erb redirect "/tweets/new"
      end
    end
     get "/tweets/:id" do
      @tweet = Tweet.find(params[:id])
       if Helpers.is_logged_in?(session)
        erb :"tweets/show_tweet"
      else
        redirect "/login"
      end
    end
     get "/tweets/:id/edit" do
       @tweet = Tweet.find_by_id(params[:id])
       if Helpers.is_logged_in?(session) && @tweet.user == Helpers.current_user(session)
        erb :"tweets/edit_tweet"
      else
        redirect "/login"
      end
    end
    patch "/tweets/:id" do
      @tweet = Tweet.find(params[:id])
       if params[:content].strip != ""
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end
    delete "/tweets/:id" do
      @tweet = Tweet.find(params[:id])
      if @tweet.user == Helpers.current_user(session)
        @tweet.destroy
      end
      redirect "/tweets"
    end

end
