require 'test_helper'

class ChefTest < ActiveSupport::TestCase
   
   def setup
      @chef = Chef.new(chefname: "John", email: "john@example.com") 
   end
   
   test "chef should be valid" do
       assert @chef.valid?
   end
   
   test "chefname should be present" do
       @chef.chefname = ""
       assert_not @chef.valid?
   end
   
   test "chefname should not be too long" do
       @chef.chefname = "a" * 41
       assert_not @chef.valid?
   end
   
   test "chefname should not be too short" do
       @chef.chefname = "aa"
       assert_not @chef.valid?
   end
   
   test "email must be present" do
       @chef.email = ""
       assert_not @chef.valid?
   end
   
   test "email should be within bounds" do
       @chef.email = "a" * 101 + "@example.com"
       assert_not @chef.valid?
   end
   
   
   test "email should be unique" do
       dup_chef = @chef.dup
       dup_chef.email = @chef.email.upcase
       @chef.save
       assert_not dup_chef.valid?
   end
   
   test "email should be valid address" do
       valid_addresses = %w[user@eee.com R_TDD@ee.hello.org user@example.com first.last@eem.au laura+joe@monk.com]
       valid_addresses.each do |va|
           @chef.email = va
           assert @chef.valid?, '#{va.inspect} should be valid'
       end
   end
   
   test "email should reject invalid address" do
       invalid_addresses = %w[user@example,com user_at_org user.anc@example eee@i_am_.com foo@ee+aar.com]
       invalid_addresses.each do |ia|
           @chef.email = ia
           assert_not @chef.valid?, '#{ia.inspect} should be invalid'
       end
   end
    
end