#!/usr/bin/env ruby
require 'open3'
require './lib/erd/factory_helper'

def main()
    # Removes previous factory files
    Open3.popen2e("rm -rf test/factories/*"){ |i, oe, t| puts oe.read() }

    helper = FactoryHelper.new()

    # Reads all table names and columns in the db/schema file
    Open3.popen2e("awk '/create_table/,/end/' \"db/schema.rb\"") { |i, oe, t| 
        helper.schema_content = helper.format_content(oe.read())
    }

    helper.create_factories()
end

main()
