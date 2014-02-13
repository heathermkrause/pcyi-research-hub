class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  def after_sign_in_path_for(resource)
    "/documents"
  end

  def after_sign_out_path_for(resource_or_scope)
    "/documents"
  end

  def error_messages(error_object)
    error_object.full_messages.join("</br>")
  end

end
