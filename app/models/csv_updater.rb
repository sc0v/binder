class CsvUpdater
  # Defines a class that compares two sets of database states; one from existing ActiveRecords
  # and the other from an uploaded CSV file.
  
  # After comparison, makes an array of changes (rows present in CSV but not in ActiveRecord
  # and rows present in ActiveRecord but not in CSV)
  
    # populates @new_set with records from uploaded CSV
    def add_from_csv(input_file, tablename)
      names_set = Set.new
      full_set = Set.new
  
      csv_text = File.read(input_file)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        names_set.add(row[0])
        full_set.add(row)
      end
  
      names_string = tablename + '_names_new'
      full_string = tablename + '_full_new'
  
      # storing hashes in the default Rails cache
      Rails.cache.write(names_string, names_set)
      Rails.cache.write(full_string, full_set)
    end
  
    # populates @old_set with records from existing database
    def add_from_database(tablename)
      old_set = Set.new
      tablename.classify.constantize.all.each do |org|
        old_set.add(org.name)
      end
  
      names_string = (tablename + '_names_old')
  
      Rails.cache.write(names_string, old_set)
    end
  
    # compares @new_set and @old set and returns a 2D array
    # [[records in new but not old], [records in old but not new]]
    def compare(tablename)
      new_set = Rails.cache.read(tablename + '_names_new')
      old_set = Rails.cache.read(tablename + '_names_old')
  
      add_array = Set.new()
  
      new_set.each do |e|
        if !(old_set.include?(e))
          add_array << e
        end
      end
  
      Rails.cache.write(tablename + '_insertions', add_array)
    end
  
  end