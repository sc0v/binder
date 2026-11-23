# frozen_string_literal: true

require 'csv'

module Carnival
  # Imports a Spring Carnival's reference data from the CSV files in
  # lib/seeds/<folder>/: organizations and their build steps, charge types,
  # FAQs, shift types, store items, tools and scissor lifts. bin/rails
  # carnival:import runs it; models= (comma-separated, e.g.,
  # models=organization,tool) limits it to some of them. db/seeds.rb uses it
  # for the development database's reference data.
  class Import # rubocop:disable Metrics/ClassLength -- one section per CSV file
    DEFAULT_FOLDER = '2025 seeds'

    ONE_STORY_ELECTRICAL = ['Cables Inspection', 'Devices Inspection', 'Final Inspection'].freeze
    TWO_STORY_ELECTRICAL = [
      'First Floor Cable Inspection', 'First Floor Devices Inspection',
      'Second Floor Cable Inspection', 'Second Floor Devices Inspection',
      'Final Inspection'
    ].freeze
    ASA_KKG_ELECTRICAL = [
      'First Floor Cable Inspection', 'First Floor Devices Inspection',
      'First Floor Final Inspection', 'Second Floor Cable Inspection',
      'Second Floor Devices Inspection', 'Second Floor Final Inspection'
    ].freeze

    # Each building organization's electrical inspection steps
    ELECTRICAL_STEPS = {
      'Alpha Epsilon Pi' => TWO_STORY_ELECTRICAL,
      'Phi Delta Theta' => ONE_STORY_ELECTRICAL,
      'Sigma Phi Epsilon' => TWO_STORY_ELECTRICAL,
      'Alpha Phi' => ONE_STORY_ELECTRICAL,
      'Alpha Chi Omega' => ONE_STORY_ELECTRICAL,
      'Delta Delta Delta' => ONE_STORY_ELECTRICAL,
      'Delta Gamma' => TWO_STORY_ELECTRICAL,
      'Kappa Alpha Theta' => TWO_STORY_ELECTRICAL,
      'Kappa Kappa Gamma' => ASA_KKG_ELECTRICAL,
      'Asian Student Association' => ASA_KKG_ELECTRICAL,
      'Chinese Students Association' => ONE_STORY_ELECTRICAL,
      'Fringe' => ONE_STORY_ELECTRICAL,
      'Student Dormitory Council' => ONE_STORY_ELECTRICAL,
      'TSA/HKSA' => ONE_STORY_ELECTRICAL,
      'Sustainable Earth/Theme Park Engineering Group' => ONE_STORY_ELECTRICAL,
      'KGB/Roboclub' => ONE_STORY_ELECTRICAL,
      'MENASA/Spirit' => ONE_STORY_ELECTRICAL,
      'Society of Women Engineers' => ONE_STORY_ELECTRICAL,
      'Alpha Phi Omega' => ONE_STORY_ELECTRICAL
    }.freeze

    SHIFT_TYPES = ['Watch Shift', 'Security Shift', 'Coordinator Shift'].freeze

    # The loaders in the order they run, by the name models= uses
    STEPS = {
      'organization' => :load_organizations,
      'organizationbuildstatus' => :load_build_statuses,
      'organizationbuildstep' => :load_build_steps,
      'chargetype' => :load_charge_types,
      'faq' => :load_faqs,
      'shifttype' => :load_shift_types,
      'shift' => :load_shifts,
      'storeitem' => :load_store_items,
      'tool' => :load_tools,
      'scissorlift' => :load_scissor_lifts,
      'certification' => :load_certifications
    }.freeze

    def initialize(folder: DEFAULT_FOLDER, models: [])
      @folder = folder
      @models = models.map { |model| model.to_s.downcase.strip }
    end

    def run
      Rails.logger.debug 'Seeding Database...'
      STEPS.each { |model, step| send(step) if load?(model) }
    end

    private

    attr_reader :folder

    def load?(model)
      @models.empty? || @models.include?(model)
    end

    def csv(file)
      CSV.parse(Rails.root.join('lib', 'seeds', folder, file).read, headers: true, skip_blanks: true)
    end

    def load_organizations
      Rails.logger.debug '  Organizations'
      csv('organizations.csv').each do |row|
        Organization.create(
          name: row['name'].strip,
          organization_category: organization_category(row),
          short_name: row['short_name'],
          booth_type: row['booth_type'].presence
        )
      end
    end

    def organization_category(row)
      building = row['is_building'] == 'TRUE'
      category = OrganizationCategory.find_by(name: row['organization_category'].strip)
      category ||= OrganizationCategory.create(name: row['organization_category'].strip, building:)
      if category.building != building
        Rails.logger.debug 'OrganizationCategory is_building inconsistent'
        raise
      end
      category
    end

    # if models_to_seed.length == 0 || models_to_seed.include?('participant')
    # Rails.logger.debug '  Participants'
    #
    # csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}participants.csv").read
    # csv = CSV.parse(csv_text, headers: true)
    # csv.each do |row|
    #   p row['organization']
    #   organization = Organization.find_by(name: row['organization'].strip)
    #   unless organization
    #     Rails.logger.debug { "    Organization (#{row['organization'].strip}) does not exist error" }
    #     raise
    #   end
    #
    #   participant = Participant.find_by(eppn: "#{row['andrewid'].strip}@andrew.cmu.edu")
    #   unless participant
    #     #user = User.find_by(email: "#{row['andrewid'].strip}@andrew.cmu.edu")
    #     #user ||= User.create(email: "#{row['andrewid'].strip}@andrew.cmu.edu")
    #
    #     #user.add_role :admin if row['admin'] == 'TRUE'
    #     #participant = Participant.create(andrewid: row['andrewid'], user:)
    #     participant = Participant.create(eppn: "#{row['andrewid'].strip}@andrew.cmu.edu")
    #   end
    #
    #   Membership.create(organization: Organization.find_by(name: row['organization'].strip),
    #                     participant: participant, title: row['title'],
    #                     is_booth_chair: row['booth_chair'] == 'TRUE')
    #
    #   m = Membership.find_by(participant_id:participant.id)
    #   unless m
    #      m = Membership.create(organization: Organization.find_by(name: row['organization'].strip),
    #                            participant: participant, title: row['title'],
    #                            is_booth_chair: row['booth_chair'] == 'TRUE')
    #   end
    #   if row['booth_chair'] == 'TRUE'
    #      m.is_booth_chair = true
    #      m.save
    #   end
    #   if m.organization_id == nil
    #      Rails.logger.debug {" participant : #{row['andrewid'].strip} , org: #{row['organization'].strip} "}
    #      m.organization_id = Organization.find_by(name:row['organization'].strip).id
    #      m.save
    #   end
    # end
    # end

    def load_build_statuses
      Rails.logger.debug '  Organization Build Status'
      Organization.find_each do |o|
        next unless o.building?

        OrganizationBuildStatus.create(status_type: 'structural', organization: o)
        OrganizationBuildStatus.create(status_type: 'electrical', organization: o)
      end
    end

    def load_build_steps
      Rails.logger.debug '  Organization Build Steps'
      two_story = csv('two_story_organization_build_steps.csv')
      one_story = csv('one_story_organization_build_steps.csv')
      Organization.find_each do |o|
        next unless o.building?

        # Manually change which orgs are 2-story in organization.csv
        (o.two_story? ? two_story : one_story).each { |row| create_build_step(o, row) }
      end
      ELECTRICAL_STEPS.each { |org_name, steps| create_electrical_steps(org_name, steps) }
    end

    def create_build_step(organization, row)
      status = OrganizationBuildStatus.where(organization:, status_type: row['status_type']).first
      OrganizationBuildStatus.create(status_type: row['status_type'], organization:) if status.nil?
      OrganizationBuildStep.create(
        title: row['title'],
        requirements: row['requirements'],
        organization_build_status: status,
        is_enabled: true
      )
    end

    def create_electrical_steps(org_name, steps)
      status = electrical_status(org_name)
      return unless status

      steps.each_with_index do |title, index|
        OrganizationBuildStep.create!(
          title: title, requirements: '', organization_build_status: status, step: index + 1, is_enabled: true
        )
      end
    end

    def electrical_status(org_name)
      org = Organization.find_by(name: org_name)
      unless org
        Rails.logger.debug { "Skipping electrical steps for #{org_name} (not found)" }
        return
      end

      status = OrganizationBuildStatus.find_by(organization: org, status_type: 'electrical')
      Rails.logger.debug { "Skipping electrical steps for #{org_name} (no electrical status)" } unless status
      status
    end

    def load_charge_types
      Rails.logger.debug '  Charge Types'
      csv('charge_types.csv').each do |row|
        ChargeType.create(
          name: row['name'].strip,
          description: row['description'] || '',
          default_amount: Integer(row['default_amount'] || '0')
        )
      end
    end

    def load_faqs
      Rails.logger.debug '  FAQs'
      csv('faqs.csv').each do |row|
        organization_category = OrganizationCategory.find_by(name: row['organization_category'])
        FAQ.create(question: row['question'].strip, answer: row['answer'].strip, organization_category:)
      end
    end

    # Rails.logger.debug '  Tasks'
    #
    # csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}tasks.csv").read
    # csv = CSV.parse(csv_text, headers: true)
    # csv.each do |row|
    #   Task.create(name: row['name'].strip, description: row['description'].strip,
    #               due_at: DateTime.strptime(row['due_at'], '%m/%d/%Y %H:%M:%S'))
    # end
    #

    def load_shift_types
      Rails.logger.debug 'Shift Types'
      SHIFT_TYPES.each { |name| ShiftType.find_or_create_by!(name:) }
    end

    # Reads a shifts.csv from the season's folder. No season since 2022 has
    # one, so the folder must hold it to load shifts.
    def load_shifts
      Rails.logger.debug 'Shift'
      csv('shifts.csv').each do |row|
        shift = create_shift(row)
        next if row['andrewids'].blank?

        row['andrewids'].split(';').each { |andrewid| assign_shift(shift, andrewid.strip) }
      end
    end

    def create_shift(row)
      organization = shift_organization(row['organization'].strip)
      shift_type = ShiftType.find_or_create_by(name: row['shift_type'].strip)
      Shift.create(organization:, shift_type:, starts_at: csv_time(row['starts_at']),
                   ends_at: csv_time(row['ends_at']), capacity: Integer(row['capacity']))
    end

    def shift_organization(name)
      organization = Organization.find_by(name:)
      return organization if organization

      Rails.logger.debug { "Organization (#{name}) does not exist" }
      raise
    end

    def csv_time(value)
      DateTime.strptime(value, '%m/%d/%Y %H:%M:%S')
    end

    def assign_shift(shift, andrewid)
      participant = Participant.find_by(eppn: "#{andrewid}@andrew.cmu.edu")
      unless participant
        Rails.logger.debug { "    Participant (#{andrewid}) does not exist" }
        raise
      end
      ShiftParticipant.create(shift:, participant:)
    end

    def load_store_items
      Rails.logger.debug '  Store'
      csv('store.csv').each do |row|
        StoreItem.create(
          name: row['name'].strip,
          price: Float(row['price'] || '0'),
          quantity: Integer(row['quantity'] || '0')
        )
      end
    end

    def load_tools
      Rails.logger.debug '  Tools'
      csv('tools.csv').each do |row|
        tool_type = ToolType.find_or_create_by(name: row['name'].strip)
        Tool.create(barcode: Integer(row['barcode']), tool_type:, description: row['description'])
      rescue StandardError
        Rails.logger.debug row['barcode']
      end
    end

    def load_scissor_lifts
      Rails.logger.debug '  Scissor Lifts'
      csv('scissor_lifts.csv').each { |row| ScissorLift.create(name: row['name']) }
    end

    # Reads a certifications.csv (certification, andrewid) from the season's
    # folder, creating each certification type and its tool type as needed.
    def load_certifications
      Rails.logger.debug '  Certifications'
      csv('certifications.csv').each do |row|
        participant = Participant.find_by(eppn: "#{row['andrewid'].strip}@andrew.cmu.edu")
        participant ||= Participant.create(eppn: "#{row['andrewid'].strip}@andrew.cmu.edu")
        Certification.create(participant:, certification_type: certification_type(row['certification'].strip))
      end
    end

    def certification_type(name)
      found = CertificationType.find_by(name:)
      return found if found

      tool_type = ToolType.find_or_create_by(name:)
      created = CertificationType.create(name:)
      ToolTypeCertification.create(tool_type:, certification_type: created)
      created
    end
  end
end
