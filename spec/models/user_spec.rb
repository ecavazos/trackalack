require 'spec_helper'

describe User do
  before do
    @user = create_user(:first_name => 'Foo', :last_name => 'Bar')
  end

  describe "#fullname" do
    subject { @user.fullname }

    it { should eq('Foo Bar') }
  end

  describe "#pathname" do
    subject { @user.pathname }

    it { should eq('foo_bar') }
  end
end
