class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  validates :challenge, presence: true
  validates :user, presence: true

end
