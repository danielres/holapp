require 'spec_helper'

describe Duration do

  describe 'attributes' do
    expect_it { to have_attribute('durable_id') }
    expect_it { to have_attribute('durable_type') }
    expect_it { to have_attribute('starts_at') }
    expect_it { to have_attribute('ends_at') }
    expect_it { to have_attribute('quantifier') }
    expect_it { to respond_to('name') }
  end

end
