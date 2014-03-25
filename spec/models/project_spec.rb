require 'spec_helper'

describe Project do

  describe 'attributes' do
    expect_it { to have_attribute('name') }
    expect_it { to have_attribute('description') }
    expect_it { to have_attribute('starts_at') }
    expect_it { to have_attribute('ends_at') }
    expect_it { to have_attribute('type') }
  end

  describe 'associations' do
    expect_it { to have_many(:memberships) }
    expect_it { to have_many(:members).through(:memberships) }
  end

  describe 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_uniqueness_of(:name).case_insensitive }
  end

end
