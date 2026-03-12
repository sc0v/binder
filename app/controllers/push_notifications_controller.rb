# frozen_string_literal: true

class PushNotificationsController < ApplicationController
  skip_forgery_protection only: [:subscribe]

  def subscribe
    subscription = NotificationSubscription.find_or_initialize_by(endpoint: subscription_params[:endpoint])
    subscription.assign_attributes(subscription_params.merge(participant_id: Current.user&.id))

    case subscription.save
    when true
      render json: { success: true, id: subscription.id }, status: :created
    else
      render json: { success: false, errors: subscription.errors.full_messages }, status: :unprocessable_entity
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

  def subscription_params
    params.expect(subscription: [:endpoint, :auth, :p256dh])
  end
end
