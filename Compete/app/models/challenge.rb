class Challenge < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters"}
  validates_uniqueness_of :name
  validates_length_of :name,
                      :minimum => 4
end
