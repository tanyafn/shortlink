require 'spec_helper'

describe 'Shortlink' do
  describe '#set_permalink' do
    let!(:existing_permalink){ TestModel.create().shortlink }
    let!(:non_existing_permalink){ existing_permalink.reverse }

    before { allow(TestModel).to receive(:generate_permalink).and_return(existing_permalink, non_existing_permalink) }

    let(:new_job){ TestModel.create }

    it "sets unique permalink" do
      expect(new_job.shortlink) == non_existing_permalink
    end
  end
  
end