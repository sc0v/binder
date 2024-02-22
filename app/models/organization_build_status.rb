class OrganizationBuildStatus < ApplicationRecord
  belongs_to :organization

  has_many :organization_build_steps

  # If an Organization has a Build_Status, but not any Build_steps,
  # This Method Creates Build Steps to Have as Defaults
  def create_steps(booth_type: nil)
    return if organization_build_steps.present?
    # Also Need to Case on Structural / Electrical!
    case booth_type
    when :two_story
      self.organization_build_steps.create(
        title: "First Floor Level",
        requirements: "",
        step: 1,
        completed: false)
      self.organization_build_steps.create(
        title: "First Floor Walls",
        requirements: "",
        step: 2,
        completed: false)
      self.save
    when :one_story
    when :blitz
    when :doghouse
    else
      # Shouldn't get here
      Rails.logger.debug 'Tried to create steps for invalid type of booth'
    end
  end
end
