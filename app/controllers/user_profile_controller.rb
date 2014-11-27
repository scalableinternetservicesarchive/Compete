class UserProfileController < ApplicationController

	helper_method :convertToShortDate, :convertBirthdayToAge
	
	def show
  		@user = User.find(params[:id])
	end

	def update
    	@user = User.find(params[:id])

    	if @user.update(user_params)
    		sign_in(@user, :bypass => true)
      		redirect_to user_profile_path(@user.id)
      		flash[:notice] = 'Profile updated.'
    	else
      		redirect_to user_profile_path(@user.id)
    		flash[:notice] = 'Fuck'
    	end
  	end

    private

    def user_params
    	params.require(:user).permit(:name, :location, :birthday, :email, :password, :password_confirmation, :current_password)
    end


	def convertToShortDate(time)
		t = time.strftime("%d/%m/%Y")
	end

	def convertBirthdayToAge(dob)
		now = Time.now.utc.to_date
  		now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end
end
