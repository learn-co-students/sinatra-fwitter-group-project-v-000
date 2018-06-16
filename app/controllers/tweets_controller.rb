class TweetsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/tweets' do
    if logged_in?
      @users = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
     else
      redirect to "/login"
    end

  end


  get '/tweets/new' do

    @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
              @user = current_user
        erb :'tweets/create_tweet'
       else
        redirect "/login"
        end
    end

    post '/tweets' do
      @tweet = Tweet.new(params)
       @user = current_user
       # This is where we set the name for song/ it want us to pass in an hash.
binding.pry
          if logged_in? && @tweet.save 

            @tweet = Tweet.create(:content => params[:content])  # shovel in Title into figure.titles to be used in the views folder
            @user.tweets << @tweet
            redirect "tweets/show_tweet"
           else
             erb :'/tweets/new'
          end
    end


      get "/tweets/:id" do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
              @user = current_user
        erb :'/tweets/show_tweet'
       else
        redirect to "/login"
        end

      end

    # <this connect here

    patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])

    if logged_in
      @tweets.content = Tweet.create(params[:tweet])  # shovel in Title into figure.titles to be used in the views folder
    end

    # :Note I can explicit with each.. but figures contains everthing already

    @tweets.save

    redirect to "/tweets/#{@tweets.id}"

  end

end
