
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
      binding.pry
      if logged_in? && params[:content] == ""
        redirect to '/tweets/new'
      elsif logged_in?
        @tweet = Tweet.new(content: params[:content]) #@tweet = params[:content] is not enough to create a whole new instance
        current_user.tweets << @tweet #@tweets not needed, changed tweets.erb form to current_user
        #shows all a single users tweets
        redirect to '/tweets/tweets'
      else
        redirect to "/login"
      end
    end

end
