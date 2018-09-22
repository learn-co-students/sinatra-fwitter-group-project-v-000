require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do  # tweet / GET request / read action
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do    #CREATE action - GET request
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do     #CREAT action - POST request
    @tweet = Tweet.new(params)   #@tweet = Tweet.create(:content =>params[:content], :user_id =>params[:user_id])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do   # Get action / Update request
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do   # Get action / edit request
    @tweet = Tweets.find_by(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do    # Patch action /update request
    @tweet = Tweet.find_by(params[:id])
    if !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect "tweets/#{params[:id]}"
    else
      redirect "tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do   # Delete action / Delete request
    if logged_in?
       @tweet = current_user.tweets.find_by(params[:id])
        if tweet && tweet.destroy
        redirect '/tweets'
     else
      redirect "/tweets/login"
    end
  end
end

#  get '/tweets' do     # Get request / check if user login
#    if logged_in?
#      user = current_user
#      erb :'/tweets/'
#    else
#      redirect to '/login'
#    end
#  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def slug
     @slug = slugify(self.username)
  end
   def slugify(name)
      split_on_apostrophes = name.split(/[']/)
      name_without_apost = split_on_apostrophes.join
      name_array = name_without_apost.downcase.split(/[\W]/)
      name_array.delete_if{|x|x==""}
      new_name = name_array.join("-")
  end
   def self.find_by_slug(slug)
    self.all.detect{|x|x.slug == slug}
  end
  end

end
