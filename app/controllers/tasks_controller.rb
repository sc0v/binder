class TasksController < ApplicationController
  def index
    @upcoming = Task.upcoming.all
    @recently_completed = Task.unscoped.not_uncompleted.order('updated_at DESC').limit(5).all
  end
end
