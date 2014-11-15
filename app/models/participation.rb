class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  has_many :progresses

  validates :challenge, presence: true
  validates :user, presence: true

  def total_gain
    progresses.sum(:gain)
  end

end
