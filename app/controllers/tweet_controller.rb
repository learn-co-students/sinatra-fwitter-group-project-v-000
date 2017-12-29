class TweetController<ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets=Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/new' do
    #binding.pry
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet=Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get 'tweets/:id' do
    if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
       erb :'tweets/show_tweet'
     else
       redirect to '/login'
     end
  end

  get 'tweet/:id/delete' do

  end

end
