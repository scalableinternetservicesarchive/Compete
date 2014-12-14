class Challenge < ActiveRecord::Base
  include PublicActivity::Common



  enum sports: [:Swimming, :Running]
  enum categories: [:Collaboration, :Competition]
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :progresses, :dependent => :destroy
  has_many :participations, :dependent => :destroy
  validates :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :name,
                      :minimum => 4

  validate :check_dates

  #after_save    :expire_challenge_all_cache
  #after_destroy :expire_challenge_all_cache

  def check_dates
    if self.start.present? && self.start < Date.today
      errors.add(:start, "can not be in the past")
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

  def root_participations
    participations

  end

  def collab_gain
    progresses.sum(:gain)
  end
=begin
  def self.all_cached
    Rails.cache.fetch('Challenge.all') { all }
  end

  def expire_challenge_all_cache
    Rails.cache.delete('Challenge.all')
  end
=end
end
