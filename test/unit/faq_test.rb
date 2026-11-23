# frozen_string_literal: true

require 'test_helper'

class FaqTest < ActiveSupport::TestCase
  context 'With a proper context, ' do
    setup do
      @faq1 = FactoryBot.create(:faq, question: 'how to sign a waiver?')
      @faq2 = FactoryBot.create(:faq, question: 'how to build a booth?')
    end

    # Scope
    should 'show that a search scope works' do
      @ans = FAQ.search('sign a waiver?')

      assert_equal 'how to sign a waiver?', @ans[0].question
    end
  end
end
