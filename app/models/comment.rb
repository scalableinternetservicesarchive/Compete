class Comment < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  validates :challenge, presence: true
  validates :user, presence: true

end
