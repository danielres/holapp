require 'spec_helper'

describe News::Item do
  describe 'attributes' do
    expect_it { to have_attribute('summary') }
    expect_it { to have_attribute('body') }
  end
end
