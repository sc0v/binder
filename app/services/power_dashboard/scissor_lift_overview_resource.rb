# frozen_string_literal: true

module PowerDashboard
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
      list = ScissorLift.includes(:scissor_lift_checkouts).to_a
      list.sort_by do |lift|
        checkout = lift.current_checkout
        remaining =
          if checkout&.due_at.present?
            checkout.due_at - now
          else
            Float::INFINITY
          end
        [lift.is_checked_out? ? 1 : 0, remaining, lift.name.to_s]
      end
    end
  end
end
