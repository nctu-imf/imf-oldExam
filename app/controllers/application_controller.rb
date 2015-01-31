class ApplicationController < ActionController::Base

	before_action :set_locale

	def set_locale
	  # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
	  if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
	    session[:locale] = params[:locale]
	  end

	  I18n.locale = session[:locale] || I18n.default_locale
	end

  # Override devise's method
  # Redirect to courses page after user signed in
  def after_sign_in_path_for(resource)
    grade_path(1)
  end

  def info_for_paper_trail
    # Save additional info
    { ip: request.remote_ip }
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = "您目前的帳號沒有這個權限"
    redirect_to :back
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_filter :configure_permitted_parameters, if: :devise_controller?


   protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
   end

  private
    def record_not_found
      flash.now[:alert] = '請不要自己輸入網址！'
      render 'home/index', status: 404
    end
end
