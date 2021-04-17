require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  require "test_helper"

  class UserTest < ActiveSupport::TestCase
    def setup
      @admin = Admin.new(phone: "8778899878", otp: "123456")
    end

    test "should be valid" do
      assert @admin.valid?
    end

    test "phone number should be present" do
      @admin.phone = "      "
      assert_not @admin.valid?
    end
  end

end
