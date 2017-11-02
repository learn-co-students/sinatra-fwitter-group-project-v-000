class TweetsController < Sinatra::Base

    get '/' do

      erb :index
    end

  #Create The Tweet - C
    get '/tweets/new' do
      if logged_in?
      erb :'tweets/create_tweet'
      else
        flash[:message] = "Please log in to write a tweet."

        redirect to 'users/login'
      end
    end

    post '/tweets' do
      if !params[:content].empty?
        @tweet = Tweet.new(content: params[:content])
        @tweet.save
        @user = current_user
        @user.tweets << @tweet
        redirect to "/tweets/#{@tweet.id}"
      else
        flash[:message] = "Please write something to post!"
        redirect to "/tweets/new"
      end
    end

  #Show The Tweet - R

    get '/tweets' do
      @user = current_user
      erb :'tweets/tweets'
    end

    get '/tweets/:id' do
      @user = current_user

      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    end

    #Edit the Tweet - U

    get '/tweets/:id/edit' do

      erb :'tweets/edit_tweet'
    end

    post '/tweets/:id' do

      erb :'tweets/show_tweet'
    end

    #Delete Tweet - D

    post '/tweets/:id/delete' do

      redirect to "/tweets"
    end
end
