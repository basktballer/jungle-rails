class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_HTTP_USERNAME'], password: ENV['ADMIN_HTTP_PASSWORD']

  def show
  end
end
