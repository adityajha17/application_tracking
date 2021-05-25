
class JWebToken
    ADMIN_SECRET_KEY = Rails.application.credentials.jwt[:ADMIN_SECRET_KEY]. to_s
  
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ADMIN_SECRET_KEY)
    end
  
    def self.decode(token)
      decoded = JWT.decode(token, ADMIN_SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end