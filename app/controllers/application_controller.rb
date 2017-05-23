require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(params["user"])
    redirect to '/tweets'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures' do
   @figure = Figure.create(params["figure"])
   if !params[:landmark][:name].empty?
     @figure.landmarks << Landmark.create(params[:landmark])
   end

   if !params[:title][:name].empty?
     @figure.titles << Title.create(params[:title])
   end

   @figure.save
   redirect to "/figures/#{@figure.id}"
  end

   post '/figures/:id' do
     @figure = Figure.find(params[:id])
     @figure.update(params[:figure])
     if !params[:title][:name].empty?
       @figure.titles.build(name: params[:title][:name])
     end
     if !params[:landmark][:name].empty?
       @figure.landmarks.build(name: params[:landmark][:name])
     end
     @figure.save
     redirect to "/figures/#{@figure.id}"
   end

end
