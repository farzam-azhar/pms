class HomeController < ApplicationController
  def index
    @top_projects = Project.top_projects.first(5)
    @bottom_projects = Project.bottom_projects.first(5)
  end
end
