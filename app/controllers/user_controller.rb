class UserController < ApplicationController
    before_action :authorize_request, except: [
                                        :login, 
                                        :sign_up, 
                                        :reset_password,
                                        :request_reset_password
                                    ]

    def sign_up
        user = CreateUserService.call(
            create_user_params[:email], 
            create_user_params[:password],
            create_user_params[:first_name], 
            create_user_params[:last_name], 
        )
        if user.valid?
            api_response(status: true, message: "Successfully created user", data: nil, status_code: :created)
        else
            api_response(status: false, message: user.errors.objects.first.full_message, data: nil, status_code: :unprocessable_entity)
        end
    end

    def login
        user = GetUserService.call(sign_in_params[:email])
        if user && user.authenticate(sign_in_params[:password])
            api_response(status: true, message: "Successfully Logged in", data: user.as_json, status_code: :ok)
        else
            api_response(status: false, message: "Error in authenticating user, kindly check your credentials", data: nil, status_code: :unprocessable_entity)
        end
    end

    def change_password
        if !@current_user.authenticate(change_password_params[:old_password])
            return api_response(status: false, message: "Old password don't match.", data: nil, status_code: :unprocessable_entity)
        end

        if change_password_params[:password] != change_password_params[:password2]
            return api_response(status: false, message: "Passwords don't match.", data: nil, status_code: :unprocessable_entity)
        end

        if @current_user.update({password: change_password_params[:password]})
            return api_response(status: true, message: "User password has been change.", data: nil, status_code: :ok)
        end

        api_response(status: false, message: "Failed in changing password", data: nil, status_code: :unprocessable_entity)
    end

    def request_reset_password
        user = GetUserService.call(reset_password_params[:email])
        if !user
            return api_response(status: false, message: "A user with email does not exit", data: nil, status_code: :unprocessable_entity)
        end

        reset_token = ResetTokenService::GetResetTokenService.call({ user_id: user.id })
        if reset_token
            reset_token.update(user_id: user.id)
            return api_response(status: true, message: "Reset link has been sent to your mail.", data: nil)
        end

        activation_code = ResetTokenService::GenerateResetTokenService.call(user)
        api_response(status: true, message: "Reset link has been sent to your mail.", data: nil)
    end

    def reset_password
        token_obj = ResetTokenService::GetResetTokenService.call({ link: reset_token_params[:link] })
        return api_response(status: false, message: "Token does not exist", data: nil, status_code: :unprocessable_entity) unless token_obj.present?
        return api_response(status: false, message: "Failed to update password.", data: nil, status_code: :unprocessable_entity) unless token_obj.user.update({password: reset_token_params[:password]})
        return api_response(status: true, message: "Password successfully changed", data: nil)
    end

    private
    def create_user_params
        params.permit(:email, :first_name, :last_name, :password)
    end

    def sign_in_params
        params.permit(:email, :password)
    end

    def change_password_params
        params.permit(:old_password, :password, :password2)
    end

    def reset_password_params
        params.permit(:email)
    end

    def reset_token_params
        params.permit(:link, :password)
    end

end
