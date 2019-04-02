
class TweetsController < ApplicationController #ApplicationController inheritance needed for logged_in?
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }
    #always check params and shotgun and browser when dealing with this
    get '/tweets' do
        if logged_in?
         @tweets = Tweet.all
         erb :'tweets/tweets'
        else
         redirect to "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
         erb :'tweets/new'
        else
          redirect to "/login"
        end
    end

    get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
        #elsif params[:id] = "tweets"
        else
          redirect to "/login"
        end
    end

    post '/tweets' do
      if logged_in? && (params[:content] == "")
        redirect to '/tweets/new'
      elsif logged_in?
        @tweet = Tweet.new(content: params[:content]) #@tweet = params[:content] is not enough to create a whole new instance
        current_user.tweets << @tweet
        @tweets = current_user.tweets
        #redirect to '/tweets/tweets' this is a file, not a path
        redirect to '/tweets'
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        erb :"/tweets/edit_tweet"
      else
        redirect to "/login"
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      if logged_in?
        if !(params["content"].empty?)
          @tweet.update(content: params["content"])
          redirect to("/tweets/#{@tweet.id}") #remember to redirect
        else
          redirect to ("/tweets/#{@tweet.id}/edit")
        end
      else
        redirect to "/login"
      end
    end

    delete '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        @user = User.find_by(id: @tweet.user_id)
        if current_user == @user
          #delete action logged in does not let a user delete a tweet they did not create
          @user.tweets.delete(@tweet)
          Tweet.all.delete(@tweet)
        end
        redirect to("/tweets")
      else
        redirect to "/login"
      end
    end

end
