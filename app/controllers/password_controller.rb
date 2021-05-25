class PasswordController < ApplicationController
    before_action :authorize_request
    def update_password
        if @current_user
            if @current_user.update(password_params)
                render json: {
                    status: 200,
                    info: "Password changed Successfully"
                }
            else
                render json: {
                    status: 500,
                    info: "Type wrong password"
                }
            end
        else
            render json: { status: 500, info: "Require User login" }
        end
    end

    private

	def password_params
		params.permit(:password, :password_confirmation)
	end
end
