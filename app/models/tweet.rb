class Tweet < ActiveRecord::Base
  belongs_to :user

  def to_slug
    "#{id}-#{title.gsub(/\W/, "-").squeeze("-")}".downcase
  end

  def show
    @post = Post.find(params[:id].to_i)
    render_404 && return unless params[:id] == @post.to_slug
  end

  def render_404
    render :file => Rails.root + "public/404.html", :status => :not_found
  end
end
