require 'spec_helper'

describe Tag do

  describe 'attributes' do
    expect_it { to have_attribute('name') }
    expect_it { to have_attribute('description') }
  end

  describe 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    expect_it { to have_many(:taggings).dependent(:destroy) }
    expect_it { to have_many(:taggings_as_taggable).dependent(:destroy) }
  end

  describe 'hierarchy' do
    let(:java){ FactoryGirl.create(:tag, name: 'java') }
    let(:jee){ FactoryGirl.create(:tag, name: 'jee') }
    let(:css){ FactoryGirl.create(:tag, name: 'css') }
    before(:each) do
      Tagging.create( tag: java, taggable: jee, context: 'tag_parents' )
    end
    describe '#pole?' do
      it 'returns true when tag is a pole, false if not' do
        expect(java.pole?).to be_true
        expect(jee.pole?).to  be_false
        expect(css.pole?).to  be_false
      end
    end
    describe '#children' do
      it 'returns the children of a tag' do
        expect(java.children).to match_array [ jee ]
        expect(jee.children).to  match_array []
        expect(css.children).to  match_array []
      end
    end
    describe '#parents' do
      it 'returns the parents of a tag' do
        expect(java.parents).to match_array []
        expect(jee.parents).to  match_array [ java ]
        expect(css.parents).to  match_array []
      end
    end
    describe '#ancestors' do
      let(:jsf) { FactoryGirl.create(:tag, name: 'jsf') }
      let(:html) { FactoryGirl.create(:tag, name: 'html') }
      before(:each) do
        Tagging.create( tag: html, taggable: jsf, context: 'tag_parents' )
        Tagging.create( tag: jee, taggable: jsf, context: 'tag_parents')
      end
      it 'returns the ancestors of a tag' do
        expect(jsf.ancestors).to match_array [ java, jee, html ]
      end
    end
  end

end
