class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		erb :'/figures/index'
	end

	get '/figures/new' do
		erb :'/figures/new'
	end

	get '/figures/:id' do
		@figure = Figure.find_by(id: params[:id])
		erb :'/figures/show'
	end

	post '/figures' do
		@figure = Figure.create(name: params["figure"]["name"])
		@figure.title_ids = params["figure"]["title_ids"]

		new_title = Title.all.find_or_create_by(name: params["new_title"])
		@figure.titles << new_title
		@figure.landmark_ids = params["figure"]["landmark_ids"]

		new_landmark = Landmark.all.find_or_create_by(name: params["figure"]["new_landmark_name"], year_completed: params["figure"]["new_year_constructed"])
		@figure.landmarks << new_landmark
		@figure.save

		redirect "/figures/#{@figure.id}"
	end

	get '/figures/:id/edit' do
		@figure = Figure.find_by_id(params[:id])
		erb :'/figures/edit'
	end

	patch '/figures/:id' do
		@figure = Figure.find_by_id(params[:id])
		@figure.name = params["figure"]["name"]
		@figure.title_ids = params["figure"]["title_ids"]
		@figure.landmark_ids = params["figure"]["landmark_ids"]

		new_title = Title.all.find_or_create_by(name: params["new_title"])
		@figure.titles << new_title
		new_landmark = Landmark.all.find_or_create_by(name: params["new_landmark"], year_completed: params["new_year_constructed"])
		@figure.landmarks << new_landmark
		@figure.save

		redirect "/figures/#{@figure.id}"

	end
end
