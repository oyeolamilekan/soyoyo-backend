class ApplicationController < ActionController::API
    # rescue_from StandardError, with: :render_error_response

    def not_found
        render json: { error: 'not_found' }
    end

    def authorize_request_or_authorize_request_using_api_key
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        if header.start_with?("pk") || header.start_with?("sk")
            authorize_request_using_api_key
        else
            authorize_request
        end
    end

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = DecodeJsonWebToken.call(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { status: false, message: "Invalid token", data: nil }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { status: false, message: "Invalid token", data: nil }, status: :unauthorized
        end
    end

    def load_yaml_file(name)
        YAML.load(File.open("#{Rails.root.to_s}/#{name}"), symbolize_names: true)
    end

    def authorize_request_using_api_key
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        begin
            api_key_obj = ApiKey.find_by(private_key: token)
            raise ActiveRecord::RecordNotFound if api_key_obj.blank?
            @business_id = api_key_obj.business_id
        rescue ActiveRecord::RecordNotFound => e
            raise ApiUnauthorizedException 'This api key is not authorized to make this request'
        end
    end

    def api_response(status:, message:, data:, status_code: nil)
        return render json: {
            status: status,
            message: message,
            data: data
        },
        status: status_code || :ok
    end

    def render_error_response(exception)
        render json: { status: false, message: exception.message, data: nil }, status: :internal_server_error
    end
end
