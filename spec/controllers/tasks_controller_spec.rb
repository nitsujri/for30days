require 'spec_helper'

describe TasksController do

  before :each do
    request.env["HTTP_REFERER"] = "http://google.com/"
  end

  describe "Create Task" do
    before(:each) do

      @user = FactoryGirl.create(:user)
      @task = FactoryGirl.create(:task)
      sign_in @user

    end

    describe "Visit Complete" do
      before(:each) do
        @log_cnt = TaskLog.count
        get :completed, { :user_id => @user.id, :task_id => @task.id }
      end

      it "marks task done for day" do
        # TaskLog.first.should.present?
        TaskLog.count.should eq(@log_cnt + 1)
      end

      it "double visit should fail" do
        #Visit #2
        get :completed, { :user_id => @user.id, :task_id => @task.id }

        #The value should not go up after extra visit
        TaskLog.count.should eq(@log_cnt + 1)
      end
    end

    it "cannot be marked completed after 30 days" do

    end

    it "cannot be marked while not active" do

    end
  end

  describe "Start Task" do
    before :each do

      @user = FactoryGirl.create(:user)
      @task = FactoryGirl.create(:task_inactive)

      sign_in @user

    end

    it "should become active" do
      get :start, { :user_id => @user.id, :task_id => @task.id }

      expect(Task.first.status).to eq("active")
    end
  end
end
