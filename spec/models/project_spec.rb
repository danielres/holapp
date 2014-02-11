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
end
