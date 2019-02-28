
class Story < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :genre, presence: true
  validates :summary, presence: true
 end
