require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples/contexts'
require_relative 'shared_examples/form_providers'

describe AddingAPerson do
  subject{ described_class.new(user, User.new(name: 'Alfred Hitchie') ) }
  let(:user){ build(:no_roles_user) }

  include_examples 'a context'
  include_examples 'a form provider'

  context 'when authorized' do
    before{ authorization.call }
    it 'works' do
      subject.call
      expect( User.last.first_name ).to eq 'Alfred'
      expect( User.last.last_name ).to eq 'Hitchie'
    end
  end

end
