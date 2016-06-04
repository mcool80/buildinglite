class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_locale
  after_action :verify_authorized, unless: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      flash[:alert] = t("You are not authorized to perform this action")
      redirect_to(request.referrer || root_path)
    end
   
    def set_locale
      I18n.available_locales = [:en, :sv]
      I18n.default_locale = :sv
      session[:locale] = params[:locale] || session[:locale] || I18n.default_locale
      I18n.locale = session[:locale]
    end
    
    # Setup community(s) and apartment for user
    def set_globals
      if user_signed_in?
        $current_apartment = current_user.apartment
        if params[:apartment_id] and current_user.admin? and not current_user.community.nil?
           $current_apartment = Apartment.where(:id => params[:apartment_id], :community_id => current_user.community.id).first
        end
        if not $current_apartment.nil? and not $current_apartment.community.nil? then
          $current_community = $current_apartment.community
        end
      end
      if $current_community.nil? then
        $current_community = Community.new
      end
      if $current_apartment.nil? then
        $current_apartment = Apartment.new
      end
    end
end
