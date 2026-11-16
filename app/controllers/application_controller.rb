class ApplicationController < ActionController::Base

  before_action :determine_musicat_settings

  rescue_from ActiveRecord::RecordNotFound, with: :error_record_not_found


  layout 'neutral'

  def error_action_not_authorized
    render 'errors/action_not_authorized', status: 401
  end

  def error_matching_route_not_found
    render 'errors/record_not_found', status: 404
  end

  def error_record_not_found
    render 'errors/record_not_found', status: 404
  end


  protected

  def after_sign_in_path_for(administrator)
    session["administrator_return_to"] || admin_root_path
  end

  def determine_musicat_settings
    @musicat_settings = QueryMusicatSettings.get
  end

end
