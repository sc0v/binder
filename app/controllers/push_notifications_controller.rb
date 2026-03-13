# frozen_string_literal: true

class PushNotificationsController < ApplicationController
  skip_forgery_protection only: [:subscribe]

  def subscribe
    subscription = find_or_build_subscription
    if subscription.save
      render json: { success: true, id: subscription.id }, status: :created
    else
      render_subscription_error(subscription)
    end
  end

  def unsubscribe
    subscription = NotificationSubscription.find(params[:id])
    subscription.destroy
    render json: { success: true }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Subscription not found' }, status: :not_found
  end

  private

  def find_or_build_subscription
    subscription =
      NotificationSubscription.find_or_initialize_by(
        endpoint: subscription_params[:endpoint]
      )
    subscription.assign_attributes(
      subscription_params.merge(participant_id: Current.user&.id)
    )
    subscription
  end

  def render_subscription_error(subscription)
    render json: {
             success: false,
             errors: subscription.errors.full_messages
           },
           status: :unprocessable_entity
  end

  def subscription_params
    params.expect(subscription: %i[endpoint auth p256dh])
  end
end
