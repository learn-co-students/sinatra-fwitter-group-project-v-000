class TweetController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get 'tweets/new' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to 'tweets/new'
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    else
    redirect to  '/tweets/#{@tweet.id}'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
          if @tweet.user_id == current_user.id
              erb :'tweets/edit_tweet'
          else
            redirect to '/tweets'
          end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to 'tweets/#{params[:id]}/edit'
    else
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "tweets/#{@tweet.id}"
  end
end


end
