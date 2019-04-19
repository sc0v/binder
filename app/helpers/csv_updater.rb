class CsvUpdater
  # Defines a class that compares two sets of database states; one from existing ActiveRecords
  # and the other from an uploaded CSV file.
  
  # After comparison, makes an array of changes (rows present in CSV but not in ActiveRecord
  # and rows present in ActiveRecord but not in CSV)
  
  # populates @new_set with records from uploaded CSV
  def add_from_csv(input_file, tablename)
    if tablename == 'participant'
      add_participants_from_csv(input_file)
      add_memberships_from_csv(input_file)
    elsif tablename == 'organization'
      add_organizations_from_csv(input_file)
    elsif tablename == 'tool'
      add_tools_from_csv(input_file)
    elsif ['shift', 'task', 'event', 'certification', 'organization_status', 'shift_participant', 'store_purchase', 'organization_timeline_entry'].include?(tablename)
      csv_to_cache(input_file, tablename)
    end

    if ['organization', 'tool', 'participant'].include?(tablename)
      add_from_database(tablename)
      compare(tablename)
    end

    if tablename == 'participant'
      add_from_database('membership')
      compare('membership')
    end
  end

  # -------------------------------------------------------------------------------------
  # add_from_csv methods
  # -------------------------------------------------------------------------------------

  def add_organizations_from_csv(input_file)
    names_set = Set.new
    full_set = Set.new

    csv_text = File.read(input_file)
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      names_set.add(row['name'])
      full_set.add(row)
    end

    names_string = 'organization_names_new'
    full_string = 'organization_full_new'

    # storing hashes in the default Rails cache
    Rails.cache.write(names_string, names_set)
    Rails.cache.write(full_string, full_set)
  end

  def add_tools_from_csv(input_file)
    names_set = Set.new
    full_set = Set.new

    csv_text = File.read(input_file)
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      names_set.add(Integer(row['barcode']))
      full_set.add(row)
    end

    names_string = 'tool_names_new'
    full_string = 'tool_full_new'

    # storing hashes in the default Rails cache
    Rails.cache.write(names_string, names_set)
    Rails.cache.write(full_string, full_set)
  end

  def add_participants_from_csv(input_file)
    names_set = Set.new
    full_set = Set.new

    csv_text = File.read(input_file)
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      names_set.add(row['andrewid'])
      full_set.add(row)
    end

    names_string = 'participant_names_new'
    full_string = 'participant_full_new'

    # storing hashes in the default Rails cache
    Rails.cache.write(names_string, names_set)
    Rails.cache.write(full_string, full_set)
  end

  def add_memberships_from_csv(input_file)
    names_set = Set.new
    full_set = Set.new

    csv_text = File.read(input_file)
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      names_set.add(row['andrewid'] + '.' + row['organization'].strip)
      full_set.add(row)
    end

    names_string = 'membership_names_new'
    full_string = 'membership_full_new'

    # storing hashes in the default Rails cache
    Rails.cache.write(names_string, names_set)
    Rails.cache.write(full_string, full_set)
  end

  def csv_to_cache(input_file, tablename)
    names_set = Set.new
    full_set = Set.new

    csv_text = File.read(input_file)
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      full_set.add(row)
    end

    # not making shift_full_new because no comparison is done
    full_string = tablename + '_insertions'

    # storing hashes in the default Rails cache
    Rails.cache.write(full_string, full_set)
  end

  # -------------------------------------------------------------------------------------
  # add_from_database methods
  # -------------------------------------------------------------------------------------

  # populates @old_set with records from existing database
  def add_from_database(tablename)
    old_active_set = Set.new
    old_inactive_set = Set.new

    tablename.classify.constantize.all.each do |i|
      if i.active?
        if tablename == 'participant'
          old_active_set.add(i.andrewid)
        elsif tablename == 'organization'
          old_active_set.add(i.name)
        elsif tablename == 'tool'
          old_active_set.add(i.barcode)
        elsif tablename == 'membership'
          old_active_set.add(i.participant.andrewid + '.' + i.organization.name.strip)
        end
      else
        if tablename == 'participant'
          old_inactive_set.add(i.andrewid)
        elsif tablename == 'organization'
          old_inactive_set.add(i.name)
        elsif tablename == 'tool'
          old_inactive_set.add(i.barcode)
        elsif tablename == 'membership'
          old_inactive_set.add(i.participant.andrewid + '.' + i.organization.name.strip)
        end
      end
    end

    active_names_string = (tablename + '_names_active_old')
    inactive_names_string = (tablename + '_names_inactive_old')

    Rails.cache.write(active_names_string, old_active_set)
    Rails.cache.write(inactive_names_string, old_inactive_set)
  end

  # -------------------------------------------------------------------------------------
  # compare methods
  # -------------------------------------------------------------------------------------

  # compares @new_set and @old set and returns a 2D array
  # [[records in new but not old], [records in old but not new]]
  def compare(tablename)
    new_set = Rails.cache.read(tablename + '_names_new')
    old_active_set = Rails.cache.read(tablename + '_names_active_old')
    old_inactive_set = Rails.cache.read(tablename + '_names_inactive_old')

    add_set = Set.new()
    deactivate_set = Set.new()
    reactivate_set = Set.new()

    new_set.each do |e|
      if !(old_active_set.include?(e))
        if !(old_inactive_set.include?(e))
          add_set << e
        else
          reactivate_set << e
        end
      end
    end

    old_active_set.each do |e|
      if !(new_set.include?(e))
        deactivate_set << e
      end
    end

    Rails.cache.write(tablename + '_insertions', add_set)
    Rails.cache.write(tablename + '_deactivations', deactivate_set)
    Rails.cache.write(tablename + '_reactivations', reactivate_set)
  end

  # -------------------------------------------------------------------------------------
  # seed methods
  # -------------------------------------------------------------------------------------

  def run_mandatory_seeds
    seed_organizations()
    seed_participants()
    seed_memberships()
    seed_tools()
    seed_shifts()
  end

  def run_optional_seeds
    if Rails.cache.read('task_insertions')
      seed_tasks()
    end

    if Rails.cache.read('certification_insertions')
      seed_certifications()
    end
  end
  
  def seed_organizations
    insertions = Rails.cache.read('organization_insertions')
    deactivations = Rails.cache.read('organization_deactivations')
    reactivations = Rails.cache.read('organization_reactivations')

    # Insertions
    Rails.cache.read('organization_full_new').each do |row|
      if insertions.include? row['name']
        organization_category ||= OrganizationCategory.find_by_name(row['organization_category'].strip)
        organization_category ||= OrganizationCategory.create(name: row['organization_category'].strip, is_building: row['is_building'] == "TRUE")
        if organization_category.is_building != (row['is_building'] == "TRUE")
          puts 'OrganizationCategory is_building inconsistent'
          # error out somehow
          return nil
        end
        Organization.create(name: row['name'].strip, organization_category: organization_category, short_name: row['short_name'])
      elsif reactivations.include? row['name']
        Organization.search(row['name']).first.update(active: true)
      end
    end

    # Deactivations
    Organization.active.each do |org|
      if deactivations.include? org.name
        org.update(active: false)
      end
    end
  end

  def seed_participants
    insertions = Rails.cache.read('participant_insertions')
    deactivations = Rails.cache.read('participant_deactivations')
    reactivations = Rails.cache.read('participant_reactivations')

    # Insertions
    Rails.cache.read('participant_full_new').each do |row|
      andrewid = row['andrewid']
      if insertions.include?(andrewid) && !Participant.find_by_andrewid(andrewid)
          # TODO: nil/existing checks re: user
          user = User.create(email: andrewid.strip + "@andrew.cmu.edu")
          if row['admin'] == "TRUE"
            user.add_role :admin
          end
          participant = Participant.create(andrewid: andrewid, user: user)
      elsif reactivations.include? andrewid
        Participant.find_by_andrewid(andrewid).update(active: true)
      end
    end

    # Deactivations
    # Should Users be deactivated along with Participants? (similarly with org aliases etc)
    Participant.active.each do |i|
      if deactivations.include?(i.andrewid)
        i.update(active: false)
      end
    end
  end

  def seed_memberships
    insertions = Rails.cache.read('membership_insertions')
    deactivations = Rails.cache.read('membership_deactivations')
    reactivations = Rails.cache.read('membership_reactivations')

    # Insertions

    Rails.cache.read('membership_full_new').each do |row|
      org = row['organization']
      andrewid = row['andrewid']
      title = row['title']
      booth_chair = row['booth_chair']

      if insertions.include?(andrewid + '.' + org)
        organization = Organization.find_by_name(org.strip)
        if !organization
          puts '    Organization (' + org.strip + ') does not exist error'
          # error out
        end

        participant = Participant.find_by_andrewid(andrewid)

        Membership.create(organization: organization, participant: participant, title: title, is_booth_chair: booth_chair)
      end
    end

    # Deactivations

    Membership.active.each do |p|
      if deactivations.include? p.participant.andrewid + '.' + p.organization.name
        p.update(active: false)
      end
    end

    # Reactivations
   
    Membership.inactive.each do |t|
      if reactivations.include?(t)
        t.update(active: true)
      end
    end

  end

  def seed_tools
    insertions = Rails.cache.read('tool_insertions')
    deactivations = Rails.cache.read('tool_deactivations')
    reactivations = Rails.cache.read('tool_reactivations')

    # Insertions

    Rails.cache.read('tool_full_new').each do |row|
      barcode = Integer(row['barcode'])
      if insertions.include?(barcode)
        tool_type ||= ToolType.find_by_name(row['tool_type'].strip)
        tool_type ||= ToolType.create(name: row['tool_type'].strip)
        Tool.create(barcode: Integer(barcode), tool_type: tool_type, description: row['description'])
      end
    end

    # Deactivations

    Tool.active.each do |t|
      if deactivations.include?(t.barcode)
        t.update(active: false)
      end
    end

    # Reactivations

    Tool.inactive.each do |t|
      if reactivations.include?(t.barcode)
        t.update(active: true)
      end
    end
  end

  def seed_shifts
    # Deactivate all current shifts
    Shift.active.each do |s|
      s.update(active: false)
    end

    # Insert uploaded shifts
    insertions = Rails.cache.read('shift_insertions')

    insertions.each do |row|
      organization = Organization.find_by_name(row['organization'].strip)
      if !organization
        puts '    Organization (' + row['organization'].strip + ') does not exist'
        # error out
      end
    
      shift_type ||= ShiftType.find_by_name(row['shift_type'].strip)
      shift_type ||= ShiftType.create(name: row['shift_type'].strip)
    
      shift = Shift.create(organization: organization, shift_type: shift_type, starts_at: DateTime.strptime(row['starts_at'], '%m/%d/%Y %H:%M:%S'), ends_at: DateTime.strptime(row['ends_at'], '%m/%d/%Y %H:%M:%S'), required_number_of_participants: Integer(row['required_number_of_participants']))
    
      if (row['andrewid'] || "") != ""
        participant = Participant.find_by_andrewid(row['andrewid'].strip)
        if !participant
          puts '    Participant (' + row['andrewid'] + ') does not exist'
          # error out
        end
    
        ShiftParticipant.create(shift: shift, participant: participant)
      end
    end 
  end

  def seed_certifications
    insertions = Rails.cache.read('certification_insertions')

    insertions.each do |row|
      certification_type = CertificationType.find_by_name(row['certification'].strip)
      if !certification_type
        tool_type = ToolType.find_by_name(row['certification'].strip)
        if !tool_type
          tool_type = ToolType.create(name: row['certification'].strip)
          puts '    ToolType (' + row['certification'].strip + ') did not exist, created it'
        end
    
        certification_type = CertificationType.create(name: row['certification'].strip)
        ToolTypeCertification.create(tool_type: tool_type, certification_type: certification_type)
      end
    
      participant = Participant.find_by_andrewid(row['andrewid'].strip)
      if !participant
        user = User.create(email: row['andrewid'].strip + "@andrew.cmu.edu")
        participant = Participant.create(andrewid: row['andrewid'], user: user)
      end
    
      Certification.create(participant: participant, certification_type: certification_type)
    end
  end

  def seed_tasks
    insertions = Rails.cache.read('task_insertions')

    insertions.each do |row|
      Task.create(name: row['name'].strip, description: row['description'].strip, due_at: DateTime.strptime(row['due_at'], '%m/%d/%Y %H:%M:%S'))
    end
  end

  # -------------------------------------------------------------------------------------
  # deactivation & waiver reset methods
  # -------------------------------------------------------------------------------------

  def deactivate_tables
    Certification.active.each do |e|
      e.update(active:false)
    end
    Task.active.each do |e|
      e.update(active:false)
    end
    Event.active.each do |e|
      e.update(active:false)
    end
    OrganizationStatus.active.each do |e|
      e.update(active:false)
    end
    ShiftParticipant.active.each do |e|
      e.update(active:false)
    end
    StorePurchase.active.each do |e|
      e.update(active:false)
    end
    OrganizationTimelineEntry.active.each do |e|
      e.update(active:false)
    end
  end

  def deactivate_optional_tables
    Task.active.each do |e|
      e.update(active:false)
    end
    Certification.active.each do |e|
      e.update(active:false)
    end
  end

  def reset_waiver_signatures
    Participant.all.each do |p|
      p.update(has_signed_waiver: nil)
      p.update(has_signed_hardhat_waiver: nil)
      p.update(waiver_start: nil)
    end
  end

end