class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :most_used_skills
  helper_method :most_used_interests
  helper_method :most_used_locations

  layout 'flatty'

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def most_used_skills
      @most_used_skills ||= ActsAsTaggableOn::Tag.joins(:taggings).where('taggings.context = ?', 'skills').most_used(5)
    end

    def most_used_interests
      @most_used_interests ||= ActsAsTaggableOn::Tag.joins(:taggings).where('taggings.context = ?', 'interests').most_used(5)
    end

    def most_used_locations
      @most_used_locations ||= User.select('location, latitude, longitude, count(*) count').group('location').order('count').limit(5)
    end

end
