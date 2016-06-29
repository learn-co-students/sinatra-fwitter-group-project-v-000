class CategoryController < ApplicationController

  get '/category/:id' do
    @category = Category.find_by(id: params[:id])
    erb :'posts/show_post'
  end
end
