require_relative '../spec_helper'

describe Challenge do

  it "should be visible to only the right users" do
    u_admin = FactoryGirl.build(:user, :role => 2)
    u_super = FactoryGirl.build(:user, :role => 1)
    u_participant = FactoryGirl.build(:user, :role => 0)
    u_random = FactoryGirl.build(:user, :role => 0)
    u_random_super = FactoryGirl.build(:user, :role => 1)

    koek_challenge = FactoryGirl.create(:challenge, :supervisor => u_super)

    koek_challenge.visible_for_user?(u_admin).should be_true
    koek_challenge.visible_for_user?(u_super).should be_true
    koek_challenge.visible_for_user?(u_participant).should be_false
    koek_challenge.visible_for_user?(u_random_super).should be_false
    koek_challenge.state = 'pending'
    koek_challenge.visible_for_user?(u_participant).should be_false
    koek_challenge.state = 'approved'
    koek_challenge.visible_for_user?(u_participant).should be_true
    koek_challenge.visible_for_user?(u_random_super).should be_true
  end

  it "should be editable to only the right users" do
    u_admin = FactoryGirl.build(:user, :role => 2)
    u_super = FactoryGirl.build(:user, :role => 1)
    u_participant = FactoryGirl.build(:user, :role => 0)
    u_random = FactoryGirl.build(:user, :role => 0)
    u_random_super = FactoryGirl.build(:user, :role => 1)

    koek_challenge = FactoryGirl.create(:challenge, :supervisor => u_super)

    koek_challenge.editable_by_user?(u_admin).should be_true
    koek_challenge.editable_by_user?(u_super).should be_true
    koek_challenge.editable_by_user?(u_participant).should be_false
    koek_challenge.editable_by_user?(u_random_super).should be_false
    koek_challenge.state = 'pending'
    koek_challenge.editable_by_user?(u_admin).should be_true
    koek_challenge.editable_by_user?(u_super).should be_false
    koek_challenge.editable_by_user?(u_participant).should be_false
    koek_challenge.state = 'approved'
    koek_challenge.editable_by_user?(u_admin).should be_true
    koek_challenge.editable_by_user?(u_super).should be_false
    koek_challenge.editable_by_user?(u_participant).should be_false
  end

  it "should be able to determine the right state of a challenge" do
    starts_tomorrow = FactoryGirl.create(:challenge, start_date: Date.tomorrow, end_date: Date.today >> 1)
    started_yesterday = FactoryGirl.create(:challenge, start_date: Date.today - 1, end_date: Date.today >> 1)
    ended_yesterday = FactoryGirl.create(:challenge, start_date: Date.today << 1, end_date: Date.today - 1)

    starts_tomorrow.upcoming?.should be_true
    starts_tomorrow.over?.should be_false
    starts_tomorrow.running?.should be_false

    started_yesterday.upcoming?.should be_false
    started_yesterday.over?.should be_false
    started_yesterday.running?.should be_true

    ended_yesterday.upcoming?.should be_false
    ended_yesterday.over?.should be_true
    ended_yesterday.running?.should be_false
  end

  it "should be able to determine if a user can enroll" do
    starts_tomorrow = FactoryGirl.create(:challenge, start_date: Date.tomorrow, end_date: Date.today >> 1)
    started_yesterday = FactoryGirl.create(:challenge, start_date: Date.today - 1, end_date: Date.today >> 1)
    ended_yesterday = FactoryGirl.create(:challenge, start_date: Date.today << 1, end_date: Date.today - 1)

    starts_tomorrow.can_enroll?.should be_true
    started_yesterday.can_enroll?.should be_false
    ended_yesterday.can_enroll?.should be_false


    starts_tomorrow.can_unenroll?.should be_true
    started_yesterday.can_unenroll?.should be_false
    ended_yesterday.can_unenroll?.should be_false
  end

  it "should be able to decline a challenge" do
    starts_tomorrow = FactoryGirl.create(:challenge, start_date: Date.tomorrow, end_date: Date.today >> 1, :state => "pending", :count => 1)

    starts_tomorrow.decline
    starts_tomorrow.count.should eq(2)
    starts_tomorrow.state.should eq("draft")
  end

  it "should use the correct implied names" do
    draft = FactoryGirl.create(:challenge, :state => "draft", :count => 1)
    declined = FactoryGirl.create(:challenge, :state => "draft", :count => 2)
    pending = FactoryGirl.create(:challenge, :state => "pending", :count => 2)

    draft.decorate.implied_state.should eq("draft")
    declined.decorate.implied_state.should eq("declined")
    pending.decorate.implied_state.should eq("pending")
  end

  it "should see draft? equals true when challenge has state draft" do
    draft = FactoryGirl.create(:challenge, :state => "draft")

    draft.draft?.should be_true
  end 

  it "should see declined equals true when challenge has state delined" do
    declined = FactoryGirl.create(:challenge, :state => "draft", :count => 2)

    declined.declined?.should be_true
  end
  
  it "should see approved equals true when challenge has state approved" do
    approved = FactoryGirl.create(:challenge, :state => "approved")

    approved.approved?.should be_true
  end

  it "should not be running when end_date or start_date isn't present" do
    challenge = FactoryGirl.create(:challenge, :start_date => "", :end_date => "", :state => "draft")

    challenge.running?.should be_false

  end

  it "should not be over when the end_date isn't present" do
    challenge = FactoryGirl.create(:challenge, :start_date => "", :end_date => "", :state => "draft")

    challenge.over?.should be_false
  end

  it "should not be upcoming when start_date isn't present" do
    challenge = FactoryGirl.create(:challenge, :start_date => "", :end_date => "", :state => "draft")

    challenge.upcoming?.should be_true
  end

  it "should be visible for supervisor" do
    u_super = FactoryGirl.create(:user, :role => 1)
    challenge = FactoryGirl.create(:challenge, :supervisor_id => u_super.id)

    Challenge.visible_for_user(u_super).should include(challenge)

  end

  it "should be visible for the admin" do
    u_admin = FactoryGirl.create(:user, :role => 2)
    challenge = FactoryGirl.create(:challenge)

    Challenge.visible_for_user(u_admin).should include(challenge)

  end

  it "should not be visible for participants" do
    u_participant = FactoryGirl.create(:user, :role => 0)
    challenge_draft = FactoryGirl.create(:challenge)
    challenge_approved = FactoryGirl.create(:challenge, :state => 'approved')

    Challenge.visible_for_user(u_participant).should include(challenge_approved)
    Challenge.visible_for_user(u_participant).should_not include(challenge_draft)


  end

  it "should be in the supervised by list" do
    u_super = FactoryGirl.create(:user, :role => 1)
    challenge = FactoryGirl.create(:challenge, :supervisor_id => u_super.id)
    u_super2 = FactoryGirl.create(:user, :email => "other@utwente.nl", :role => 1)

    Challenge.supervised_by_user(u_super).should include(challenge)
    Challenge.supervised_by_user(u_super2).should_not include(challenge)

  end

  it "should have a human_readable_start_date" do
    challenge = FactoryGirl.create(:challenge)
    challenge_missing = FactoryGirl.create(:challenge, :start_date => "")

    challenge_missing.decorate.human_readable_start_date.should eql "TBC."
    challenge.decorate.human_readable_start_date.should eql (Date.today + 2).strftime("%d-%m-%Y")

  end

  it "should have a human_readable_end_date" do
    challenge = FactoryGirl.create(:challenge)
    challenge_missing = FactoryGirl.create(:challenge, :end_date => "")

    challenge_missing.decorate.human_readable_end_date.should eql "TBC."
    challenge.decorate.human_readable_end_date.should eql (Date.today + 4).strftime("%d-%m-%Y")

  end

 it "should show the location" do
    challenge = FactoryGirl.create(:challenge)
    challenge_missing = FactoryGirl.create(:challenge, :location => "")

    challenge.decorate.location.should eql "Zilverling"
    challenge_missing.decorate.location.should eql "TBA"
 end

 it "should decorate the supervisor" do
    u_super = FactoryGirl.create(:user, :role => 1)
    challenge = FactoryGirl.create(:challenge, :supervisor_id => u_super.id)
    challenge_missing = FactoryGirl.create(:challenge)
    challenge.decorate.supervisor.should_not be_nil
    challenge_missing.decorate.supervisor.should be_nil
 end

 it "should show day of week or TBC" do
    challenge = FactoryGirl.create(:challenge)
    challenge_missing = FactoryGirl.create(:challenge, :start_date => "")

    challenge.decorate.day_of_week.should eql (Date.today + 2).strftime("%A")
    challenge_missing.decorate.day_of_week.should eql "TBC"
 end

 it "should have readable from and till date" do
    challenge = FactoryGirl.create(:challenge)

    challenge.decorate.from_till.should eql  "From <span id=\"start_date\">" + (Date.today + 2).strftime("%d-%m-%Y") + "</span> till <span id=\"end_date\">" +  (Date.today + 4).strftime("%d-%m-%Y") +"</span>"

 end

 it "should show the correct total days" do
    challenge = FactoryGirl.create(:challenge)

    challenge.decorate.days_total.should eql 2
 end

 it "should show the correct days until end" do
    challenge = FactoryGirl.create(:challenge, :start_date => Date.today - 2)

    challenge.decorate.days_till_end.should eql 4
 end

 it "should show the correct days until start" do
    challenge = FactoryGirl.create(:challenge)

    challenge.decorate.days_till_start.should eql 3

 end

it "should show the correct percentage" do
    challenge_not_running = FactoryGirl.create(:challenge)
    challenge_running = FactoryGirl.create(:challenge, :start_date => Date.today - 2)
    challenge_finished = FactoryGirl.create(:challenge, :start_date => Date.today - 4, :end_date => Date.today - 2)

    challenge_not_running.decorate.percentage_date.should eql "0%"
    challenge_finished.decorate.percentage_date.should eql "100%"
    challenge_running.decorate.percentage_date.should eql (((((Date.today - (Date.today - 2))) / ((Date.today + 4) - (Date.today - 2))) * 100 ).to_i).to_s + "%"

end

end
