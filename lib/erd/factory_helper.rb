class FactoryHelper
    # { referencing => referenced }
    attr_accessor :associations
    # [str]
    attr_accessor :schema_content

    # corresponding initial values (checked & grouped by regex) in factory file, using lambda to take in 
    # column name and returns the string with the right type of initial value
    DEFAULT_VALUES = {
        /string|text/ => lambda { |n| "#{n} { \"MyString\" }" },
        /integer|bigint|float|decimal/ => lambda { |n| "#{n} { 1 }" },
        /boolean/ => lambda { |n| "#{n} { true }" },
        /datetime|timestamp/ => lambda { |n| "#{n} { Time.now }" },
        /date/ => lambda { |n| "#{n} { Date.today }" }
    }

    # Adapter Pattern
    # Formats input string from schema.rb specifying foreign keys into a hash table for parsing indexes
    def format_associations(str)
        # input line format: /^add_foreign_key "<referencing_table_name>", "<referenced_table_name>"$/
        assocs = {}
        str.split("\n", -1).each { |ac|
            # prunes "add_foreign_key" word 
            line = ac.scan(/\".*\"/).first
            # Sanity check to deal with trailing chars
            if !line.nil?
                referencing = line.split(", ").first
                referenced = line.split(", ").last
                assocs[referencing] = referenced
            end
        }
        assocs
    end

    # Adapter Pattern
    # Formats column contents from schema into array
    def format_content(str)
        str.split("create_table")
    end

    def create_factories
        schema_content.each { |block| 
            # Create factory file if block is not empty
            create_factory_file(block) if !block.strip.empty?
        }
    end

    private
    def create_factory_file(block)
        # Prunes all leading and trailing spaces
        cols = block.split("\n", -1)

        file_content = ""
        # Parses the table name of the first column
        factory_name = parse_table_name(cols[0]).strip
        file_content += "FactoryBot.define do\n\tfactory :#{factory_name} do\n\t\t"
        
        # Parses all lines matching the template of schema columns, excluding trailing (end)
        cols = cols.filter!{ |col| col.match?(/^\s*t\./) }
        if !cols.nil?
            parsed_columns = cols.map { |col| parse_line(col) }
            file_content += parsed_columns.filter{ |pc| !pc.empty? }.join("\n\t\t")
        end

        file_content += "\n\tend\nend"
        puts file_content
        puts "----------"
        # Writes to the corresponding factory file
    end

    def parse_table_name(create_table_line)
        # Extracts table name that is followed, pruning surrounding quotes
        create_table_line.split(",", 2).first.gsub("\"", "")
    end

    def parse_line(column_line)
        column_type = column_line.scan(/\..*\s/).first
        return parse_references(column_line) if column_type == "index"

        # Column name enclosed around the quotation marks
        column_name = column_line.scan(/\".*\"/).first
        parse_column(column_name, column_type)
    end

    def parse_column(column_name, type)
        # Ignores "created_at" and "updated_at"
        return "" if column_name.match?(/^\"(created_at|updated_at)\"$/)
        # Ignores FK fields that ends with "_id"
        return "" if column_name.match?(/_id\"$/)

        # value_type is of type [string -> string]
        value_type = DEFAULT_VALUES.find { |pattern, _| type.match?(pattern) }
        if !value_type.nil?
            return DEFAULT_VALUES[value_type.first].call(column_name.gsub(/\"/, ""))
        end
        ""
    end

    def parse_references(reference_line)
        # Find foreign key in add_references
    end
end