require 'spec_helper'

class Subject
  include Gauges
end

describe Gauges do
  #let(:class_with_my_module) {
  #  Class.new do
  #    include Gauges
  #  end
  #}
  ["unique", "unique_hour", "unique_day", "unique_month", "unique_year"].each do |unique|
    describe "##{unique}" do
      context "the user has never been seen before" do
        before :each do
          @subject = Subject.new
          @cookies = {}
          @subject.should_receive(:cookies).twice.and_return(@cookies)
        end

        it "should return 1" do
          @subject.send(unique).should==1
        end
      end

      context "The user has a current session" do
        before :each do
          @subject = Subject.new
          @cookies = {:_gauges_cookie => 1}
          @subject.should_receive(:cookies).and_return(@cookies)
        end

        it "should return 1" do
          @subject.send(unique).should==0
        end
      end
    end



  end
end