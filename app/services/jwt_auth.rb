class JwtAuth
  def self.encrypt(user_id)
    JWT.encode({ "user_id" => user_id, "exp" => 1.day.from_now.to_i }, ENV['JWT_SECRET'], 'HS256')
  end

  def self.decrypt(token)
    decoded_token = JWT.decode token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }
    decoded_token[0]["user_id"]
  end
end
