# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/new_day
  def new_day
    AdminMailer.new_day
  end

  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/close_day
  def close_day
    AdminMailer.close_day
  end

end
