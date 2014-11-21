class Progress < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :challenge
  belongs_to :user
  belongs_to :participation
  validates :challenge, presence: true
  validates :user, presence: true
  validates :participation, presence: true


end
