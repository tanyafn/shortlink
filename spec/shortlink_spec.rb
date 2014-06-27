require 'spec_helper'

describe 'Shortlink' do
  describe '#set_permalink' do
    let!(:existing_permalink){ a = TestModel.create().permalink; puts a; a }
    let!(:non_existing_permalink){ b = existing_permalink.reverse; puts b; b }

    before { allow(TestModel).to receive(:generate_permalink).and_return(existing_permalink, non_existing_permalink) } 

    it "sets unique permalink" do
      job =  TestModel.create
      puts job.inspect
      expect(job.permalink) == non_existing_permalink
    end
  end
  
end