class ApplicationController < ActionController::Base
  add_flash_types :notice, :error

  protect_from_forgery with: :exception
end
