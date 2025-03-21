# frozen_string_literal: true
class QueuesController < ApplicationController
  def index
    redirect_to queues_path
  end
end