require 'spec_helper'

describe RedirectCatch do
  describe "#touch" do
    it "should have a hit after touch is called" do
      @domain = Domain.make!
      @catch = @domain.catches.create({})
      @catch.touch
      @catch.hits.count.should == 1
    end
  end
end
