require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'

describe ViewingPeople do
  subject{ described_class.new(user) }
  let(:user){ build(:no_roles_user) }
  let(:view_context){ double('view_context') }
  let(:execution){ ->{ subject.expose_list(view_context) } }
  let(:authorization){ ->{ allow(user).to receive( :can_view_people? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end

      let(:person){ build(:person) }
      let(:presenter){ double('presenter') }
      let(:people){ [person, user] }

      before(:each) do
        expect(user).to receive(:available_people){ people }
      end

      it 'passes the people a presenter' do
        expect( PeoplePresenter )
          .to receive(:new).once
          .with( people, view_context )
          .and_return{ presenter }

        expect( presenter )
          .to receive(:to_html).once

        execution.call
      end
    end

  end

end
