require 'spec_helper'

describe BillingTypes do

  describe BillingTypes, '.all' do

    it 'should contain all billing types' do
      BillingTypes.all.should == {
        :billable     => 'Billable',
        :non_billable => 'Non-Billable',
        :no_charge    => 'No Charge'
      }
    end
  end

  describe BillingTypes, '.for_select' do

    it 'should return an array for use in select helper' do
      BillingTypes.for_select.should == [
        ['Billable', :billable],
        ['Non-Billable', :non_billable],
        ['No Charge', :no_charge]
      ]
    end
  end
end
