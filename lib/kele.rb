require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @options = { body: { email: email, password: password } }
    response = self.class.post("/sessions", @options)
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get("/users/me", headers: {"authorization" => @auth_token})
    puts JSON.parse(response.body)
  end

end
