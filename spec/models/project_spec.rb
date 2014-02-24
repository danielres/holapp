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


  describe 'validations' do
    it "requires a name" do
      expect( Project.new(name: '').errors_on(:name) ).to include "can't be blank"
    end
    it "requires name to be unique" do
      p1 = Project.new(name:'myproj').save!
      p2 = Project.new(name: 'myproj')
      expect( p2.errors_on(:name) ).to include 'has already been taken'
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
