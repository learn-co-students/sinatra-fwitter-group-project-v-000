class TweetsController <  ApplicationController


  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content].empty?
      erb '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user: current_user)
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      if current_user.id == @tweet.id
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])

    if current_user.id == @tweet.user_id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end