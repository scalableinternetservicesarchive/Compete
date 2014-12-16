# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
CONN = ActiveRecord::Base.connection
TIMES = 10

Challenge.transaction do
  TIMES.times do |i|
    name = (0...8).map { (65 + rand(26)).chr }.join
    start = Date.today.to_formatted_s(:db)
    stop = Date.today.to_formatted_s(:db)
    user_id = 1
    str = "INSERT INTO challenges (name, user_id, start, stop) values (\"#{name}\", #{user_id}, \"#{start}\", \"#{stop}\")"
    Challenge.connection.execute str
  end
end