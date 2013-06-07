require 'spec_helper'
require 'ostruct'

class Hash
  def to_ostruct
    o = OpenStruct.new(self)
    each.with_object(o) do |(k,v), o|
      o.send(:"#{k}=", v.to_ostruct) if v.respond_to? :to_ostruct
    end
    o
  end
end



describe User do
  let(:user) { FactoryGirl.create :user }

  it "be online after create" do
    user.should be_online
  end

  describe "try login with facebook" do
    before(:each) do    
      @user_attrs = FactoryGirl.attributes_for :user     
      auth_hash = { "provider" => "facebook", "uid" => "1234", "info" => { "email" => @user_attrs[:email] }, 
                        "extra" => { "raw_info" =>  { "name" => "tester"} } }
      @auth_obj = auth_hash.to_ostruct
    end

    it "should create user if not exist" do
      expect {
        User.find_for_facebook_oauth(@auth_obj)
      }.to change(User, :count).by(1)
    end

    it "should update user if it exist" do
      user = User.create(@user_attrs)
      expect {
        User.find_for_facebook_oauth(@auth_obj)
      }.to change(User, :count).by(0)
      user.reload
      user.name.should eq "tester"
    end
  end
end