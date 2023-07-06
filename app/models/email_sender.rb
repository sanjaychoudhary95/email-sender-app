class EmailSender < ApplicationRecord
  enum status: { success: 0, failure: 1 }

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true
end
