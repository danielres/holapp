require 'spec_helper'

describe News::Item, :news do
  describe 'attributes' do
    expect_it { to validate_presence_of('summary') }
    expect_it { to have_attribute('body') }
    expect_it { to validate_presence_of('language') }
    expect_it { to ensure_inclusion_of(:language).in_array(%w(fr en)) }
  end
end
