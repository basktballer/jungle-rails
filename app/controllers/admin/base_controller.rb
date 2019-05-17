
class Admin::BaseController < ApplicationController
  layout "application"
  http_basic_authenticate_with name: ENV['ADMIN_HTTP_USERNAME'], password: ENV['ADMIN_HTTP_PASSWORD']
end