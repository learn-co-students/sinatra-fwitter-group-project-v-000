class TweetsController < Sinatra::Base

  include Helper

  configure do
    set :public_folder, 'public'
    set :views, "app/views/tweets"
    enable :sessions
    set :session_secret, "what a wonderful secret this is"
    use Rack::Flash
  end

  get "/tweets" do
    @user = current_user
    @tweets = Tweet.all
    erb :tweets
  end

  get "/tweets/new" do
    erb :new
  end

  post "/tweets" do
    if params[:tweet][:content].empty?
      flash[:message] = "Tweet contents cannot be empty!"
      redirect to("/tweets/new")
    else
      current_user.tweets.create(params[:tweet])
      redirect to("/tweets")
    end
  end

  get "/tweets/:id" do
    @user = current_user
    @tweet = Tweet.find(params[:id])
    erb :show_tweet
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      erb :edit_tweet
    else
      flash[:message] = "This is not your tweet to edit!"
      redirect to("/tweets/#{@tweet.id}")
    end
  end

  patch "/tweets/:id" do
    tweet = Tweet.find(params[:id])
    if params[:tweet][:content].empty?
      flash[:message] = "Tweet contents cannot be empty!"
      redirect to("/tweets/#{tweet.id}/edit")
    elsif tweet.user == current_user
      tweet.update(params[:tweet])
    else
      flash[:message] = "This is not your tweet to edit!"
    end
    redirect to("/tweets/#{tweet.id}")
  end

  delete "/tweets/:id/delete" do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      tweet.destroy
      redirect to("/tweets")
    else
      flash[:message] = "This is not your tweet to delete!"
      redirect to("/tweets/#{tweet.id}")
    end
  end

end
