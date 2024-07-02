module JsonWebToken
  extend ActiveSupport::Concern
  # Todo: Use Rails credentials
  SECRET_KEY = "510a39ee7e598620ce8710f22c3c7062f9890e31da7f4f1e1cead006e77177507d7166bdd5538b95230edbc472549fd2bbbf1db0eaabc337d16799b70fd53a82"

  def encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded_token
  end
end
