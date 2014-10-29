class Challenge < ActiveRecord::Base
  has_many :comments
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters"}
  validates_uniqueness_of :name
  validates_length_of :name,
                      :minimum => 4

  def root_comments

  	comments
  end

end
