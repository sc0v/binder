# frozen_string_literal: true

module Dashboard
  class ScissorLiftOverviewResource
    def id
      'overview'
    end

    def name
      'Scissor Lifts Overview'
    end

    def path
      '/scissor_lifts'
    end

    def lifts
      now = Time.zone.now
      ScissorLift
        .includes(:scissor_lift_checkouts)
        .sort_by do |lift|
          checkout = lift.current_checkout
          remaining =
            checkout&.due_at.present? ? checkout.due_at - now : Float::INFINITY
          [checkout.present? ? 1 : 0, remaining, lift.name.to_s]
        end
    end
  end
end
