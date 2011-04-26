require 'spec_helper'

describe TimeEntriesController do
  login_user

  def mock_time_entry(stubs={})
    (@mock_time_entry ||= mock_model(TimeEntry).as_null_object).tap do |time_entry|
      time_entry.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all time_entries as @time_entries" do
      TimeEntry.stub(:all) { [mock_time_entry] }
      get :index
      assigns(:time_entries).should eq([mock_time_entry])
    end
  end

  describe "GET show" do
    it "assigns the requested time_entry as @time_entry" do
      TimeEntry.stub(:find).with("37") { mock_time_entry }
      get :show, :id => "37"
      assigns(:time_entry).should be(mock_time_entry)
    end
  end

  describe "GET new" do
    it "assigns a new time_entry as @time_entry" do
      TimeEntry.stub(:new) { mock_time_entry }
      get :new
      assigns(:time_entry).should be(mock_time_entry)
    end
  end

  describe "GET edit" do
    it "assigns the requested time_entry as @time_entry" do
      TimeEntry.stub(:find).with("37") { mock_time_entry }
      get :edit, :id => "37"
      assigns(:time_entry).should be(mock_time_entry)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created time_entry as @time_entry" do
        TimeEntry.stub(:new).with({'these' => 'params'}) { mock_time_entry(:save => true) }
        post :create, :time_entry => {'these' => 'params'}
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "redirects to the created time_entry" do
        TimeEntry.stub(:new) { mock_time_entry(:save => true) }
        post :create, :time_entry => {}
        response.should redirect_to(time_entry_url(mock_time_entry))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved time_entry as @time_entry" do
        TimeEntry.stub(:new).with({'these' => 'params'}) { mock_time_entry(:save => false) }
        post :create, :time_entry => {'these' => 'params'}
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "re-renders the 'new' template" do
        TimeEntry.stub(:new) { mock_time_entry(:save => false) }
        post :create, :time_entry => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested time_entry" do
        TimeEntry.should_receive(:find).with("37") { mock_time_entry }
        mock_time_entry.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :time_entry => {'these' => 'params'}
      end

      it "assigns the requested time_entry as @time_entry" do
        TimeEntry.stub(:find) { mock_time_entry(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "redirects to the time_entry" do
        TimeEntry.stub(:find) { mock_time_entry(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(time_entry_url(mock_time_entry))
      end
    end

    describe "with invalid params" do
      it "assigns the time_entry as @time_entry" do
        TimeEntry.stub(:find) { mock_time_entry(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "re-renders the 'edit' template" do
        TimeEntry.stub(:find) { mock_time_entry(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested time_entry" do
      TimeEntry.should_receive(:find).with("37") { mock_time_entry }
      mock_time_entry.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the time_entries list" do
      TimeEntry.stub(:find) { mock_time_entry }
      delete :destroy, :id => "1"
      response.should redirect_to(time_entries_url)
    end
  end

end
