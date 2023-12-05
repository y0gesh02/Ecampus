class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :pundishing_user
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  
  def not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
    # head :no_content
  end


  private

  def handle_not_found
		redirect_to root_path, alert: "Record not found"
	end

  def pundishing_user(exception)
    flash[:notice] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path) 
  end
end
