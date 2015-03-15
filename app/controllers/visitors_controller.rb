class VisitorsController < ApplicationController
  def index
    @users = User.all * 50
  end
end
