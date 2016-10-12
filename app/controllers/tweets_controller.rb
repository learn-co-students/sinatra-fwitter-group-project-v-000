class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?
			@tweets = Tweet.all
			@user = User.find(session[:user_id])
			erb :'/tweets/index'
		else
			redirect "/login"
		end
	end

	post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.new(content: params[:content])
      @user = User.find(session[:user_id])
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

	get '/tweets/new' do
		if logged_in?
      erb :'/tweets/new'
    else
      redirect to 'login'
    end
	end

	# show page
	get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  # edit action
  get '/tweets/:id/edit' do
  	if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(:content => params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  # delete action
  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to "/tweets/#{@tweet.id}"
    end
  end

end