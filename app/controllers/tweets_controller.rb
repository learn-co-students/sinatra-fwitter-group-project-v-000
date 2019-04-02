
class TweetsController < ApplicationController #ApplicationController inheritance needed for logged_in?
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

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
        else
          redirect to "/login"
        end
    end

    post '/tweets' do
      if logged_in? && params[:content] == ""
        redirect to '/tweets/new'
      elsif logged_in?
        @tweet = Tweet.new(content: params[:content]) #@tweet = params[:content] is not enough to create a whole new instance
        @tweets = current_user.tweets
        @tweets << @tweet
        redirect to '/tweets/tweets'
      else
        redirect to "/login"
      end
    end

end
