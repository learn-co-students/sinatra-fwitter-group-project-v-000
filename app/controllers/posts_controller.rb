class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      erb :"posts/posts"
    else
      redirect "/login"
    end

  end

  post '/posts' do

    if logged_in? && !params[:title].empty? && !params[:content].empty?
      @posts = Post.create(title: params[:title], content: params[:content], user_id: current_user.id)
      @posts.category = Category.create(name: params[:category])
      @posts.save

      redirect "/posts"
    else
      redirect "/posts/new"
    end
  end

  get '/posts/new' do
    if logged_in?
      erb :"posts/create_post"
    else
      redirect "/login"
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Post.find_by(id: params[:id])
      erb :"posts/edit_post"
    else
      redirect '/login'
    end
  end

  patch '/posts/:id' do
    #binding.pry
    @post = Post.find_by(id: params[:id])
    if logged_in? && !params["post"]["content"].empty?
      @post.update(params["post"])
      @post.save
      redirect '/posts'
    else
      redirect "/posts/#{@post.id}/edit"
    end
  end

  get '/posts/:id/edit' do
    if logged_in?
      @tweet = Post.find_by(id: params[:id])
      erb :"posts/edit_post"
    else
      redirect '/login'
    end

  end

  delete '/posts/:id/delete' do
    if logged_in?
      @user = current_user.posts
      @post = @user.find_by(id: params[:id])
      @post.delete if !@post.nil?
      redirect  '/posts'
    else
      redirect "/login"
    end

  end

end
