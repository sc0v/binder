# frozen_string_literal: true

# polls for emergency weather alerts and sends notifications to users
class WeatherAlertJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # TODO: implement weather alert polling and notifications
  end
end
