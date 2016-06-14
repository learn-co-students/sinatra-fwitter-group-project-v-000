class TweetsController < ApplicationController

# <<<<<<< HEAD
# =======
# <<<<<<< HEAD
  get '/tweets' do
    "hello world"
    erb :'tweets/tweets'
  end

  post '/tweets' do
    "hello world"
  end

  get '/tweets/create_tweet' do
    if logged_in?.empty?
      redirect "/users/login"
    else
      erb :'tweets/create_tweet'
    end
  end
end
# =======
# >>>>>>> 73185dec98942c2be5a5e29bcc88765a1e5677fd
  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

end
# <<<<<<< HEAD
# =======
# >>>>>>> 98492d5eccd0078cc4f3572fe93844596fd67123
# >>>>>>> 73185dec98942c2be5a5e29bcc88765a1e5677fd
