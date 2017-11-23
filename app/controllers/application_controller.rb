require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions

  get '/tweets/new' do 
    redirect :'/login' if !session[:id]
    erb "<form action='/tweets/new' method='post'>
    <input type='text' name='content'>Tweet</input>
    <input type='submit' id='submit'>
    </form>"
  end

  post '/tweets/new' do 
    redirect :'/tweets/new' if params[:content].blank?
    user = User.find(session[:id])
    user.tweets.build(params)
    user.save
  end

  get '/' do
    erb 'Welcome to Fwitter'
  end

  get '/signup' do 
    redirect :'/tweets' if session[:id]
  end

  post '/signup' do
    redirect :'/signup' if params[:username]==""
    redirect :'/signup' if params[:email]=="" 
    redirect :'/signup' if params[:password]==""
    
    user = User.create(params)
    session[:id] = user.id

    redirect :'/tweets'
  end

  get '/login' do

    redirect :'/tweets' if session[:id]
    
    erb "<%= session[:id].nil? %>
    <form action='/login' method='post'>
    <input type='text' name='username'>Username</input>
    <input type='text' name='password'>Password</input>
    <input type='submit' id='submit'>
    </form>"

    
  end

  post '/login' do
    user = User.find_by(username: params[:username] ).try(:authenticate, params[:password])
    session[:id] = user.id
    redirect :'/tweets'
  end

  get '/tweets' do 
    redirect :'/login' if !session[:id]
    erb "Welcome,
      <%= Tweet.all.each {|tweet| tweet.content} %>"
  end

  get '/logout' do
    session.clear
    redirect :'/login'
  end

  get "/users/:slug" do 
    @user = User.find_by_slug(params[:slug])
    erb "
      <%= @user.tweets.each {|tweet| tweet.content} %> 
    "
  end

  get "/tweets/:id/edit" do 
    redirect :'/login' if !session[:id]
    @tweet = Tweet.find(params[:id])

    erb "<form action='/tweets/edit' method='post'>
    <input type='text' name='content' value='<%= @tweet.content %>'>Tweet</input>
    <input type='text' name='id' value=<%= @tweet.id %>></input>
    <input type='submit' id='submit'>
    </form>"
  end

  post "/tweets/edit" do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].blank?

    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])

  end


  get "/tweets/:id" do
    redirect :'/login' if !session[:id]
    @tweet = Tweet.find(params[:id])

    erb "
      <%= @tweet.content %> 
      <form action='/tweets/delete' method='post'>
       <input type='text' name='id' value=<%= @tweet.id %>></input>
       <input type='submit' id='Delete Tweet'>
      </form>
      Edit Tweet
    "
  end

  post "/tweets/delete" do
    redirect :'/login' if !session[:id]
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user.id == session[:id]
    
  end 




end