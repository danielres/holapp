require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_context_by_an_authorized_user'

describe ViewingPeople do
  subject{ described_class.new(user) }
  let(:view_context){ double('view_context') }
  let(:execution){ ->{ subject.expose_list(view_context) } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'

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
