class Users::RegistrationsController < Devise::RegistrationsController
respond_to :html, :json
	# def create
	#  @user = User.new(sign_up_params)  
      
 #      respond_to do |format|  
 #        if @user.save  
 #          UserMailer.registration_confirmation(@user).deliver  
 #           render :template => "user_mailer/user_registration_acknowledgement"
 #           #   format.html do
 #        		 #    redirect_to '/users/mailer/'
 #      		   # end
 #          # format.html { redirect_to @user, notice: 'User was successfully created.'  }  
 #          # format.xml  { render :xml => @user, :status => :created, :location => @user }  
 #        else  
 #          format.html { render :action => "new" }  
 #          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }  
 #        end  
 #      end  
	# end

  def update
    super
    # redirect_to show
  end

  def show
    @user = User.find(current_user.id)

    if @user
      # redirect_to users_show_path
    end
  end

  def activate_account
    @user = User.find(params[:id])
    if @user
      @user.activated = true
      @user.activated_at = Date.new
      @user.save
      current_user = @user
      sign_in(resource_name, @user)      
      redirect_to account_activations_path
    end
  end

def sign_up(resource_name, resource)
  # sign_in(resource_name, resource)
end

protected
	def after_sign_up_path_for(resource)
    after_sign_up_path
    # redirect_to main_after_sign_up_path
    # redirect_to :controller => "main", :action => "after_sign_up"
  end  

  def after_update_path_for(resource)
    edit_user_registration_path
  end

	# def new
	# 	super
	# end

	private
 
  def sign_up_params
    params.require(:user).permit(:email,:password,:password_confirmation,:gender, :date_of_birth, :mobile,:user_name, :last_name, :first_name)
  end
 
  def account_update_params
    params.require(:user).permit(:email,:password,:password_confirmation,:gender, :date_of_birth, :mobile,:image,:current_password,:user_name, :last_name, :first_name)
  end
end
