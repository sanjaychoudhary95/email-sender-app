class EmailSendersController < ApplicationController
  def new
    @email_sender = EmailSender.new
  end

  def create
    @email_sender = EmailSender.new(email_sender_params)

    if @email_sender.valid?
      service = EmailSenderService.new(@email_sender.name, @email_sender.email, @email_sender.message)
      status = service.send_email

      if status == :success
        @email_sender.status = :success
        flash[:success] = 'Email sent successfully!'
      else
        @email_sender.status = :failure
        flash.now[:error] = 'Failed to send the email. Please try again later.'
      end
      @email_sender.save!
      redirect_to root_path
    else
      flash.now[:error] = @email_sender.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def email_sender_params
    params.require(:email_sender).permit(:name, :email, :message)
  end
end
