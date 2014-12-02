require 'spec_helper'

describe News::UserConfig, :news do
  describe 'attributes' do
    expect_it { to validate_presence_of('user_id') }
    expect_it { to have_attribute('digest_sent_at') }
    expect_it { to have_attribute('receive_digest') }
  end
  describe 'associations' do
    expect_it { to belong_to(:user).dependent(:destroy) }
  end
end
