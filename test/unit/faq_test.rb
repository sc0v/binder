# ## Schema Information
#
# Table name: `faqs`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`active`**      | `boolean`          | `default(TRUE)`
# **`answer`**      | `text(65535)`      |
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`question`**    | `text(65535)`      |
# **`updated_at`**  | `datetime`         |
#

require 'test_helper'

class FaqTest < ActiveSupport::TestCase

    context "With a proper context, " do
    setup do
      @faq1 = FactoryGirl.create(:faq, :question => "how to sign a waiver?")
      @faq2 = FactoryGirl.create(:faq, :question => "how to build a booth?")
    end

    teardown do
    end

    # Scope 
    should "show that a search scope works" do
      @ans = Faq.search("sign a waiver?")
      assert_equal "how to sign a waiver?",  @ans[0].question
    end
    
  end

end
