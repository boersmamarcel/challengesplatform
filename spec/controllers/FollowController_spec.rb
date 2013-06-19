require_relative '../spec_helper'
describe FollowController do
	include Devise::TestHelpers

	before (:each) do
		@user = FactoryGirl.create(:user)
		@user2 = FactoryGirl.create(:user, :firstname => "John", :lastname => "Ivy", :email => "j.i@student.utwente.nl")
		sign_in @user
	end

	it "should say something went wrong" do
		Follow.any_instance.stub(:save).and_return(false)
		post :create, :user_id => @user2
		flash[:notice].should include("Whoops")
	end

end