class MunicipeMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Cadastro realizado no municipe')
  end
end
