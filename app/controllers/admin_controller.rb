class AdminController < ApplicationController
  before_action :authenticated
  before_action :admin_authenticate, only: [:admin_page, :employees, :locations]

  def admin_login

  end

  def authenticate
    if Admin.first.authenticate(params[:password])
      session[:admin] = Admin.first.password_digest
      redirect_to admin_url
    else
      flash[:danger] = 'Wrong Password, Desiree'
      render 'admin_login'
    end
  end

  def update_admin
    @admin = Admin.first
    if !@admin.authenticate(params[:current_password])
      flash[:danger] = 'Incorrect Password'
      redirect_to '/admin' and return
    end
    if @admin.update_attributes(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
      cookies.permanent.signed[:authentic] = @admin.password_digest
      session[:admin] = @admin.password_digest
      flash[:info] = 'Password updated'
      redirect_to '/admin'
    else
      flash[:danger] = "Passwords don't match"
      redirect_to '/admin'
    end
  end

  def admin_page
    @admin = Admin.find(1)
    @items = Item.all
  end

  def logout
    session.delete(:admin)
    redirect_to root_url
  end

  def employees
    @admin = Admin.find(1)
    if params[:employee] && !params[:employee].empty?
      @admin.employees << params[:employee]
    end
    if params[:employees] && !params[:employees].empty?
      params[:employees].each do |employee|
        @admin.employees.delete(employee)
      end
    end
    if @admin.save
      flash[:info] = "Employees updated"
      redirect_to '/admin'
    else
      @items = Item.all
      flash[:danger] = "Oops"
      render '/admin'
    end
  end

  def locations
    @admin = Admin.first
    if params[:location] && !params[:location].empty?
      @admin.locations << params[:location]
    end
    if params[:locations] && !params[:locations].empty?
      params[:locations].each do |location|
        @admin.locations.delete(location)
      end
    end
    if @admin.save

      @admin = Admin.first
      flash[:info] = "Locations updated"
      redirect_to '/admin'
    else
      @items = Item.all
      flash[:danger] = "Oops"
      render '/admin'
    end
  end


  private

    def admin_params
      params.require(:admin).permit(:password, :password_confirmation)
    end





end
