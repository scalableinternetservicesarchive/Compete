# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
CONN = ActiveRecord::Base.connection
TIMES = 1000

#TIMES.times {Challenge.create(:user_id => 1, :name => (0...8).map { (65 + rand(26)).chr }.join, :start => Date.today, :stop => Date.today)}


ActiveRecord::Base.transaction do
  TIMES.times { Challenge.create(:user_id => 1, :name => (0...8).map { (65 + rand(26)).chr }.join, :start => Date.today, :stop => Date.today) }
end