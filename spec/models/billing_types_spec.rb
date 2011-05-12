require 'spec_helper'

describe BillingTypes do
  describe "#all" do
    it "should contain all billing types" do
      BillingTypes.all.should eq({:billable => 'Billable', :non_billable => 'Non-Billable', :no_charge => 'No Charge'})
    end
  end

  describe "#for_select" do
    it "should return an array for use in select helper" do
      BillingTypes.for_select.should eq([["Billable", :billable], ["Non-Billable", :non_billable], ["No Charge", :no_charge]])
    end
  end
end
