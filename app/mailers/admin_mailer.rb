class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.new_day.subject
  #
  def new_day(day)
    @day = day
    @greeting = "Hi"

    mail to: "Drinklowcountrylemonade@gmail.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.close_day.subject
  #
  def close_day(day)
    @day = day
    @greeting = "Hi"
    @previous_day = @day.previous_day

    mail to: "Drinklowcountrylemonade@gmail.com"
  end
end
