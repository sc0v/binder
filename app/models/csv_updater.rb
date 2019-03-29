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
    else
      # handle anything that is completely deactivated (incl. shifts)
    end

    add_from_database(tablename)
    compare(tablename)
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

  def run_seeds
    seed_organizations()
    seed_participants()
    seed_memberships()
    seed_tools()
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

  
  

end