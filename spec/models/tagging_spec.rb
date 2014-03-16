describe Tagging do

  describe 'attributes' do
    expect_it { to have_attribute('tag_id') }
    expect_it { to have_attribute('taggable_id') }
    expect_it { to have_attribute('taggable_type') }
    expect_it { to have_attribute('context') }
  end

end
