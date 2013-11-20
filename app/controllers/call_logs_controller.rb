class CallLogsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	def new_call
		Rails.logger.info params
		@phoneNumber = params[:phoneNumber]
		a = CallLog.new
		a.phoneNumber = @phoneNumber
		a.save
		render :nothing => true
	end
end
