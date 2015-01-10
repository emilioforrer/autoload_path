require 'test_helper'

class AutoloadPathTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, AutoloadPath
  end
end
