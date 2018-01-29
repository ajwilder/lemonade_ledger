class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@lemonade-ledger.herokuapp.com'
  layout 'mailer'
end
