class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def _run_params(params)
    params = params.to_unsafe_hash if params.respond_to?(:to_unsafe_hash)
    params
  end
end
