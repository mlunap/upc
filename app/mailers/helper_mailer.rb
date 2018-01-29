class HelperMailer < ApplicationMailer

  def enviar_email(user, asunto)
    @user = user
    mail( :to => @user.correo, :subject => asunto )
  end
end
