# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`created_at`**       | `datetime`         |
# **`document_id`**      | `integer`          |
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`public`**           | `boolean`          |
# **`updated_at`**       | `datetime`         |
# **`url`**              | `string(255)`      |
#

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)

  context "With a proper context, " do
    setup do
      @org = FactoryGirl.create(:organization_alias, :id => 123)
      @document = FactoryGirl.create(:document, :organization_id => @org.id, :name => "Booth")
      @document2 = FactoryGirl.create(:document, :organization_id => @org.id, :name => "Electric")
    end

    teardown do
    end

    # Validations- is there a better way to test this? 
    should "show that a document has an organization assocaited with it" do
      assert_equal 123,  @document.organization_id
    end

    #scopes 
    should "show that search scope works" do
    	@doc = Document.search('booth')
    #When actually testing you can see the name, but will default back to document when asserting it for some reason
      assert_equal 'Booth', @doc

    end
    
  end

end
