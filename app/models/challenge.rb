class Challenge < ActiveRecord::Base
  has_many :comments
  has_many :progresses
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "only allows letters"}
  validates_uniqueness_of :name
  validates_length_of :name,
                      :minimum => 4

  def root_comments

  	comments
  end

  def root_progresses
  	progresses
  end

end
