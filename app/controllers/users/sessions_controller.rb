class Users::SessionsController < Devise::RegistrationsController
	# respond_to :html, :json

	def create
	 	@user = User.find_by_email(params[:user][:email])

	 	if @user && @user.activated
	 		sign_in(resource_name, resource)
			current_user = @user
			redirect_to admin_dashboard_path 
		else
			redirect_to new_user_session_path			
		end
	end

	def new
		super
	end

	def destroy
		session.clear
		redirect_to new_user_session_path
	end

end
