class Progress < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :participation
  validates :participation, presence: true
  validates :challenge, presence: true

end
