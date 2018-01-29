class StaticPagesController < ApplicationController
  before_action :authenticated, only: [:home]

  def home
    @days = Day.where(closed: false)
  end

  def login
  end

  def authenticate
    if Admin.first.authenticate(params[:password])
      flash[:info] = 'This device is now registered to use the lemonade ledger'
      cookies.permanent.signed[:authentic] = Admin.first.password_digest
      redirect_to home_url
    else
      flash[:danger] = 'Wrong Password, Desiree'
      render 'login'
    end
  end




end
