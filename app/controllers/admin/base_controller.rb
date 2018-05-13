module Admin
  class BaseController < ApplicationController
    layout "admin"

    http_basic_authenticate_with name: "marta", password: "secret"
  end
end
