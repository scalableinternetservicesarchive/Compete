class UserProfileController < ApplicationController

	helper_method :convertToShortDate, :convertBirthdayToAge
	
	def show
  		@user = User.find(params[:id])
	end

	def convertToShortDate(time)

		t = time.strftime("%d/%m/%Y")

	end

	def convertBirthdayToAge(dob)
		now = Time.now.utc.to_date
  		now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end
end
