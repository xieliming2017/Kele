require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'
  attr_accessor :email

  def initialize(email, password)
    @email = email
    options = {
      body: {
        "email": email,
        "password": password
      }
    }

    response = self.class.post("/sessions", options)
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get("/users/me", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_messages(page=1)
    if page.nil?
      response = self.class.get("/message_threads", headers: {"authorization" => @auth_token})
    else
      response = self.class.get("/message_threads", headers: {"authorization" => @auth_token})
    end
    JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, stripped_text )
    options = {
      body: {
        "sender": "#{@email}",
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped-text": stripped_text
      }
    }
    response = self.class.post("/messages", options)

  end


end
