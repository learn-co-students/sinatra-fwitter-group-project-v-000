class TweetsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/tweets' do
    if logged_in?
      @users = User.all
      @tweets = Tweet.all
      erb :'/tweets/tweets'
     else
      redirect to "/login"
    end

  end


  get '/tweets/new' do

    if logged_in?
      @users = User.all
    erb :'/tweets/create_tweet'
    else
      redirect to "/tweets"
    end

    end

    post '/tweets' do

       # This is where we set the name for song/ it want us to pass in an hash.
          if logged_in?
            @tweets = Tweet.create(params[:tweet])  # shovel in Title into figure.titles to be used in the views folder
            @tweets.user =  User.find(session[:user_id])  #need to pass in a user_id in here..
          end
      @tweets.save
      redirect  "/tweets/#{@tweets.id}"  # "/tweet/[name of newly created figure]
    end





      get "/tweets/:id" do


        erb :'/tweets/show_tweet'

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
