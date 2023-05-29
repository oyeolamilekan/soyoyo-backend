class ApiSeverException < StandardError
    attr_reader :message
    def initialize(message)
        @message = message
    end
end

class ApiNotFoundException < StandardError
    attr_reader :message
    def initialize(message)
        @message = message
    end
end

class ApiUnauthorizedException < StandardError
    attr_reader :message
    def initialize(message)
        @message = message
    end
end