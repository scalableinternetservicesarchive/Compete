class Participation < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :challenge
  has_many :progresses, :dependent => :destroy

  validates :challenge, presence: true
  validates :user, presence: true

  def total_gain
    progresses.sum(:gain)
  end

end
