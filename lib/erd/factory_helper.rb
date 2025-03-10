require 'open3'

class FactoryHelper
    # [str]
    attr_accessor :schema_content

    # corresponding initial values (checked & grouped by regex) in factory file, using lambda to take in 
    # column name and returns the string with the right type of initial value
    DEFAULT_VALUES = {
        /string|text/ => lambda { |n| "#{n} \{ \'MyString\' \}" },
        /integer|bigint|float|decimal/ => lambda { |n| "#{n} \{ 1 \}" },
        /boolean/ => lambda { |n| "#{n} \{ true \}" },
        /datetime|timestamp/ => lambda { |n| "#{n} \{ Time.now \}" },
        /date/ => lambda { |n| "#{n} \{ Date.today \}" }
    }

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
        file_content += "FactoryBot.define do\n\tfactory \:#{factory_name} do\n\t\t"
        
        # Parses all lines matching the template of schema columns, excluding trailing (end)
        cols = cols.filter!{ |col| col.match?(/^\s*t\./) }
        if !cols.nil?
            parsed_columns = cols.map { |col| parse_line(col) }
            file_content += parsed_columns.filter{ |pc| !pc.empty? }.join("\n\t\t")
        end

        file_content += "\n\tend\nend"

        # Writes to the corresponding factory file
        Open3.popen2e("echo \"#{file_content}\" > test/factories/#{factory_name}.rb") {|i, oe, t|
            puts oe.read()
            puts "test/factories/#{factory_name}.rb created!"
        }
    end

    def parse_table_name(create_table_line)
        # Extracts table name that is followed, pruning surrounding quotes
        create_table_line.split(",", 2).first.gsub("\"", "")
    end

    def parse_line(column_line)
        # Column name enclosed around the quotation marks
        column_type = column_line.scan(/\..*\s/).first
        # Ignore indexes that are not used on the application level
        return "" if column_type.match?(/index/)
        column_name = column_line.scan(/\".*\"/).first
        parse_column(column_name, column_type)
    end

    def parse_column(column_name, type)
        # Ignores "created_at" and "updated_at"
        return "" if column_name.match?(/^\"(created_at|updated_at)\"$/)
        # Processes FK fields that ends with "_id", there should be another way to handle FK columns with aliases
        return parse_references(column_name.gsub(/([\"\[\]]|_id\"$)/, "")) if column_name.match?(/_id\"$/)


        # value_type is of type [string -> string]
        value_type = DEFAULT_VALUES.find { |pattern, _| type.match?(pattern) }
        if !value_type.nil?
            # Calls the lambda that is mapped to by the corresponding pattern
            return DEFAULT_VALUES[value_type.first].call(column_name.gsub(/\"/, ""))
        end
        ""
    end

    def parse_references(referenced_table_name)
        "association :#{referenced_table_name.strip}" 
    end
end