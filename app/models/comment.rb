class Comment < ActiveRecord::Base
  belongs_to :challenge
  validates :challenge, presence: true
  
end
