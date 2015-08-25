class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CartHelper
  include UserHelper
  include OrderItemHelper
end
