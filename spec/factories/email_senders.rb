FactoryBot.define do
  factory :email_sender do
    name { "MyString" }
    email { "xyz@yopmail.com" }
    message { "MyText" }
    status { 1 }
  end
end
