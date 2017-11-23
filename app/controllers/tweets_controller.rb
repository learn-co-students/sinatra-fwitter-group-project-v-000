class TweetsController < Sinatra::Base

  include Helper

  configure do
    set :public_folder, 'public'
    set :views, "app/views/tweets"
    set :erb, layout: :"../layout"
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
    if current_user.tweets.create(params[:tweet]).valid?
      redirect to("/tweets")
    else
      flash[:message] = "Tweet contents cannot be empty!"
      redirect to("/tweets/new")
    end
  end

  get "/tweets/:id" do
    @user = current_user
    @tweet = Tweet.find(params[:id])
    erb :show_tweet
  end

  get "/tweets/:id/edit" do
    if @tweet = current_user.tweets.find_by(id: params[:id])
      erb :edit_tweet
    else
      flash[:message] = "This is not your tweet to edit!"
      redirect to("/tweets/#{params[:id]}")
    end
  end

  patch "/tweets/:id" do
    tweet = current_user.tweets.find_by(id: params[:id])
    if !tweet
      flash[:message] = "This is not your tweet to edit!"
    elsif !tweet.update(params[:tweet])
      flash[:message] = "Tweet contents cannot be empty!"
      redirect to("/tweets/#{tweet.id}/edit")
    else
      flash[:message] = "Tweet saved successfully."
    end
    redirect to("/tweets/#{tweet.id}")
  end

  delete "/tweets/:id/delete" do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      flash[:message] = "Tweet successfully deleted."
      redirect to("/tweets")
    else
      flash[:message] = "Unable to delete this tweet. Are you logged in? Is this your tweet?"
      redirect to("/tweets/#{params[:id]}")
    end

  end

end
