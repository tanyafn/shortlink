require 'spec_helper'

describe 'Shortlink' do
  describe '#shortlink' do
    let(:obj){ TestModel.create }

    context "with default options" do
      subject{ obj.shortlink }

      it{ expect(subject).to be_a(String) }
      it{ expect(subject.length).to eq(6) }
    end

    context "with custom options" do
      subject{ obj.configured_shortlink }

      it{ expect(subject).to be_a(String) }
      it{ is_expected.to start_with('prefix') }
      it{ expect(subject.length).to eq(15) }
    end

    it 'saves unique value' do
      existing_permalink = TestModel.create.shortlink
      not_existing_permalink = existing_permalink.reverse

      allow_any_instance_of(TestModel).to receive(:generate_shortlink).and_return(existing_permalink, not_existing_permalink)

      expect(obj.shortlink).to eq(not_existing_permalink)
    end
  end
end