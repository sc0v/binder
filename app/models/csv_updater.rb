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
        add_from_database('organization')
        compare('organization')
      elsif tablename == 'tools'
        add_tools_from_csv(input_file)
      else
        # handle anything that is completely deactivated (incl. shifts)
      end
    end

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

    def seed_organizations
      insertions = Rails.cache.read('organization_insertions')
      deactivations = Rails.cache.read('organization_deactivations')

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
        end
      end

      # Deactivations
      Organization.active.each do |org|
        if deactivations.include? org.name
          org.memberships.each do |m|
            m.update(active: false)
          end
          org.update(active: false)
        end
      end
    end

    def add_tool_from_csv(input_file)
      names_set = Set.new
      full_set = Set.new
  
      csv_text = File.read(input_file)
      csv = CSV.parse(csv_text, :headers => true)

      csv.each do |row|
        names_set.add(row['barcode'])
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
        names_set.add(row['andrewid'] + '.' + row['organization'])
        full_set.add(row)
      end
  
      names_string = 'membership_names_new'
      full_string = 'membership_full_new'
  
      # storing hashes in the default Rails cache
      Rails.cache.write(names_string, names_set)
      Rails.cache.write(full_string, full_set)
    end
  
    # populates @old_set with records from existing database
    def add_from_database(tablename)
      old_set = Set.new
      tablename.classify.constantize.active.each do |i|
        if tablename == 'participant'
          old_set.add(i.andrewid)
        elsif tablename == 'organization'
          old_set.add(i.name)
        elsif tablename == 'tools'
          old_set.add(i.barcode)
        elsif tablename == 'memberships'
          old_set.add(i.participant.andrewid + '.' + i.organization.name)
        end
      end
  
      names_string = (tablename + '_names_old')
  
      Rails.cache.write(names_string, old_set)
    end

    # compares @new_set and @old set and returns a 2D array
    # [[records in new but not old], [records in old but not new]]
    def compare(tablename)
      new_set = Rails.cache.read(tablename + '_names_new')
      old_set = Rails.cache.read(tablename + '_names_old')
  
      add_set = Set.new()
      deactivate_set = Set.new()
  
      new_set.each do |e|
        if !(old_set.include?(e))
          add_set << e
        end
      end

      old_set.each do |e|
        if !(new_set.include?(e))
          deactivate_set << e
        end
      end
  
      Rails.cache.write(tablename + '_insertions', add_set)
      Rails.cache.write(tablename + '_deactivations', deactivate_set)
    end
  
  end