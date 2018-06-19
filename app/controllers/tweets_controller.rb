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
       #check if tweet is empty.
       # This is where we set the name for song/ it want us to pass in an hash.
          if logged_in? && !@tweet.content.blank? && @tweet.save
               @user.tweets << @tweet
            redirect to "/tweets/#{@tweet.id}"  # target Id of specific tweets.
           else
             redirect "/tweets/new"  #this is a route
          end
    end


      get "/tweets/:id" do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show_tweet'
       else
        redirect to "/login"
        end

      end


       get '/tweets/:id/edit' do
          @tweet = Tweet.find_by_id(params[:id]) # slug helps to find by name instaed of ID
          erb :'tweets/edit_tweet'
        end

    # <this connect here

    patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])

        if logged_in?
          @tweet.content = Tweet.create(params[:tweet])  # shovel in Title into figure.titles to be used in the views folder
        end
        # :Note I can explicit with each.. but figures contains everthing already

    @tweet.save

    redirect to "/tweets/#{@tweet.id}"

  end


    delete "/tweets/:id/delete" do       # the issue is here.
      @tweet = Tweet.find_by_id(params[:id])

      @tweet.delete
      redirect to '/tweets'
    end




end
