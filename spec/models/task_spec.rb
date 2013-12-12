require 'spec_helper'

describe Task do
  it "Fails no name" do
    expect {  Task.create!(start_date: Date.today) }.to raise_error
  end

  describe "Conflict check" do
    before :each do
      @user = create(:user)
      @task = create(:task, start_date: Time.now.in_time_zone(@user.time_zone).to_date)
    end

    it "Has a Conflict" do
      r = Task.new(id: 2, name: "test", user_id: @user.id, start_date: Time.now.in_time_zone(@user.time_zone).to_date).has_conflicts?

      r.should be(true)
    end

    it "Beyond 29 days - Conflict" do
      r = Task.new(
          id: 2,
          name: "test", 
          user_id: @user.id,
          start_date: Time.now.in_time_zone(@user.time_zone).to_date + 29.day
        ).has_conflicts?

      r.should be(true)
    end

    it "Beyond 30 days - No Conflict" do
      r = Task.new(
          id: 2,
          name: "test", 
          user_id: @user.id,
          start_date: Time.now.in_time_zone(@user.time_zone).to_date + 30.day
        ).has_conflicts?

      r.should be(false)
    end
  end

  describe "Daily Mark" do
    before :each do
      @user = create(:user)
      @task = create(:task)
      @tasklog = create(:task_log)
    end

    it "should should be marked" do
      @task.marked_today?.should eq(true)
    end

    it "time passed - not marked yet" do
      Timecop.freeze(Time.now + 1.day) do
        @task.marked_today?.should eq(false) 
      end
    end
  end
end
