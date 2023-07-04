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
            api_response true, "Successfully created user", nil, :created
        else
            api_response false, user.errors.full_messages[0], nil, :unprocessable_entity
        end
    end

    def login
        user = GetUserService.call(sign_in_params[:email])
        if user && user.authenticate(sign_in_params[:password])
            token = EncodeJsonWebToken.call({user_id: user.id})
            api_response true, "Successfully Logged in", user.as_json.merge(token: token), :ok
        else
            api_response false, "Error in authenticating user, kindly check your credentials", nil, :unprocessable_entity
        end
    end

    def change_password
        if !@current_user.authenticate(change_password_params[:old_password])
            api_response false, "Old password don't match.", nil, :unprocessable_entity
        end

        if change_password_params[:password] != change_password_params[:password2]
            api_response false, "Passwords don't match.", nil, :unprocessable_entity
        end

        if @current_user.update({password: change_password_params[:password]})
            api_response true, "User password has been change.", nil, :ok
        end

        api_response false, "Failed in changing password", nil, :unprocessable_entity
    end

    def request_reset_password
        user = GetUserService.call(reset_password_params[:email])
        if !user
            api_response false, "A user with email does not exit", nil, :unprocessable_entity
        end

        reset_token = ResetToken.find_by(user_id: user.id)
        if reset_token
            reset_token.update(user_id: user.id)
            api_response true, "Reset link has been sent to your mail.", nil
        end

        activation_code = ResetToken.create(user_id: user.id)
        api_response true, "Reset link has been sent to your mail.", nil
    end

    def reset_password
        token_obj = ResetToken.find_by()
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

end
