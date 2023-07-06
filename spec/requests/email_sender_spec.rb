require 'rails_helper'

RSpec.describe EmailSender, type: :request do
  describe 'GET #new' do
    it 'returns a success response' do
      get new_email_sender_path
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context 'When information correct' do
      it 'creates a new email sender' do
        expect do
          post email_senders_path, params: { email_sender:  correct_params }
        end.to change { EmailSender.count }.by(1)
      end

      it 'return flash success' do
        post email_senders_path, params: { email_sender:  correct_params }
        expect(flash[:success]).to eq('Email sent successfully!')
      end
    end

    context 'When information in-correct' do
      it 'failed to create email sender' do
        expect(EmailSender.count).to eq(0)
        post email_senders_path, params: { email_sender:  incorrect_params }
        expect(EmailSender.count).to eq(0)
      end

      it 'return flash error' do
        post email_senders_path, params: { email_sender: incorrect_params }
        expect(flash[:error]).to eq("Name can't be blank")
      end
    end

    context 'When api failed' do
      before do
        allow_any_instance_of(EmailSenderService).to receive(:send_email).and_return(400)
      end

      it 'return flash error' do
        post email_senders_path, params: { email_sender: correct_params }
        expect(flash[:error]).to eq("Failed to send the email. Please try again later.")
      end

      it 'creates a new email sender with failure status' do
        expect do
          post email_senders_path, params: { email_sender:  correct_params }
        end.to change { EmailSender.count }.by(1)
        expect(EmailSender.where(email: 'john@example.com').last.status).to eq("failure")
      end
    end

    context 'When api success' do
      it 'return flash success' do
        post email_senders_path, params: { email_sender: correct_params }
        expect(flash[:success]).to eq("Email sent successfully!")
      end

      it 'creates a new email sender with success status' do
        expect do
          post email_senders_path, params: { email_sender:  correct_params }
        end.to change { EmailSender.count }.by(1)
        expect(EmailSender.where(email: 'john@example.com').last.status).to eq('success')
      end
    end
  end
end

def incorrect_params
  { name: nil, email: 'john@example.com', message: 'Hello' }
end

def correct_params
  { name: 'John Doe', email: 'john@example.com', message: 'Hello' }
end
