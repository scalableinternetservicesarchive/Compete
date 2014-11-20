class Comment < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :challenge
  belongs_to :user
  validates :challenge, presence: true
  validates :user, presence: true

end
