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

end
