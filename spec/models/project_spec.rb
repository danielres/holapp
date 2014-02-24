require 'spec_helper'

describe Project do
  context 'given a name' do
    it 'initializes correctly' do
      described_class.new(name: 'Foo')
    end

    it 'has its name correctly set' do
      project = described_class.new(name: 'Foo')
      expect(project.name).to eq 'Foo'
    end
  end

  describe 'attributes' do
    let(:project){ described_class.new(name: "#{rand}") }
    it 'has an editable description' do
      project.description = 'description content'
      expect(project.description).to eq 'description content'
    end

  end

end
