class Challenge < ActiveRecord::Base
  has_many :comments
  has_many :progresses
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "only allows letters and numbers"}
  validates_uniqueness_of :name
  validates_length_of :name,
                      :minimum => 4

  validate :check_dates

  def check_dates
    if self.start.present? && self.start < Date.today
      errors.add(:start, "can nots be in the past")
    end
    if self.stop.present? && self.stop < self.start
      errors.add(:stop, "can not be before end date")
    end
  end


  def root_comments
  	comments
  end

  def root_progresses
  	progresses
  end


end
