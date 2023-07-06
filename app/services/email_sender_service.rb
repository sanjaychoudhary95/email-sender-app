class EmailSenderService
  include HTTParty

  API_URL = 'https://monroneylabels.com/pages/dealer_message.json'.freeze

  def initialize(name, email, message)
    @name = name
    @email = email
    @message = message
  end

  def send_email
    response = HTTParty.post(API_URL, body: payload)
    return :success if response.code == 200

    :failure
  rescue StandardError
    :failure
  end

  private

  def payload
    {
      v2: 2,
      form: {
        name: @name,
        email: @email,
        message: @message
      }
    }
  end
end
