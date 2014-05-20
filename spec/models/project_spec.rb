require 'spec_helper'

describe Project do

  describe 'attributes' do
    expect_it { to have_attribute('name') }
    expect_it { to have_attribute('description') }
    expect_it { to have_attribute('starts_at') }
    expect_it { to have_attribute('ends_at') }
    expect_it { to have_attribute('starts_at') }
    expect_it { to have_attribute('ends_at') }
  end

  describe 'associations' do
    expect_it { to have_many(:memberships) }
    expect_it { to have_many(:members).through(:memberships) }
  end

  describe 'associations' do
    expect_it { to have_many(:taggings).dependent(:destroy) }
  end

  describe 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_uniqueness_of(:name).case_insensitive }
  end

  # describe 'scopes' do
  #   let!(:past_project1   ){ FactoryGirl.create(:project, starts_at: nil             , ends_at: Time.new('2000')) }
  #   let!(:past_project2   ){ FactoryGirl.create(:project, starts_at: Time.new('1999'), ends_at: Time.new('2000')) }
  #   let!(:current_project1){ FactoryGirl.create(:project, starts_at: Time.new('2000'), ends_at: Time.new('3000')) }
  #   let!(:current_project2){ FactoryGirl.create(:project, starts_at: Time.new('2000'), ends_at: nil             ) }
  #   let!(:future_project1 ){ FactoryGirl.create(:project, starts_at: Time.new('3000'), ends_at: Time.new('4000')) }
  #   let!(:future_project2 ){ FactoryGirl.create(:project, starts_at: nil             , ends_at: Time.new('4000')) }
  #   let!(:future_project3 ){ FactoryGirl.create(:project, starts_at: Time.new('3000'), ends_at: nil             ) }
  #   let!(:future_project4 ){ FactoryGirl.create(:project, starts_at: nil             , ends_at: nil             ) }
  #   describe '#past' do
  #     it 'returns finished projects' do
  #       expect( Project.past ).to match_array [ past_project1, past_project2 ]
  #     end
  #   end
  #   describe '#current' do
  #     it 'returns current projects' do
  #       expect( Project.current ).to match_array [ current_project1, current_project2 ]
  #     end
  #   end
  #   describe '#future' do
  #     it 'returns future projects' do
  #       expect( Project.future ).to match_array [ future_project1, future_project2, future_project3, future_project4 ]
  #     end
  #   end
  # end

  describe 'type' do
    let(:project){ Project.new }
    it 'is nil by default' do
      expect( project.type ).to be_nil
    end
    it "is 'internal' when type value is 1" do
      project[:type] = 1
      expect( project.type.to_s ).to eq 'internal'
    end
    it "is 'external' when type value is 2" do
      project[:type] = 2
      expect( project.type.to_s ).to eq 'external'
    end
  end

end
