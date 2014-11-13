class MainController < ApplicationController
	skip_before_filter :authenticate_user!, :only => :after_sign_up

	def index
	end

	def after_sign_up
	end
end
