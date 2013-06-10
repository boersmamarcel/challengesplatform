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
    starts_tomorrow = FactoryGirl.create(:challenge, start_date: Date.tomorrow, end_date: Date.today >> 1, :state => "pending")

    starts_tomorrow.decline
    starts_tomorrow.count.should eq(1)
    starts_tomorrow.state.should eq("declined")
  end

  it "should see draft when challenge is draft?" do
    draft = FactoryGirl.create(:challenge, :state => "draft")

    draft.draft?.should be_true
  end 



end
