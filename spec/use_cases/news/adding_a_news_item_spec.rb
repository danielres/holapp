require 'spec_helper'
require 'factories_spec_helper'
require_relative '../shared_examples/contexts'
# require_relative '../shared_examples/form_providers'

describe News::AddingANewsItem do
  subject{ described_class.new(user, News::Item.new(summary: 'My news item', body: 'My news item') ) }
  let(:user){ build(:no_roles_user) }

  include_examples 'a context'
  # include_examples 'a form provider'

  context 'when authorized' do
    before{ authorization.call }
    it 'works' do
      subject.call
      expect( News::Item.last.summary ).to eq 'My news item'
    end
  end

end

