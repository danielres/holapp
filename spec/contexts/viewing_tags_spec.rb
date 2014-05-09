require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'

describe ViewingTags do
  subject{ described_class.new(user) }
  let(:user){ build(:no_roles_user) }
  let(:view_context){ double('view_context') }
  let(:execution){ ->{ subject.expose_list(view_context) } }
  let(:authorization){ ->{ allow(user).to receive( :can_view_tags? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end

      let(:tag){ build(:tag) }
      let(:presenter){ double('presenter') }
      let(:tags){ [tag] }

      before(:each) do
        expect(user).to receive(:available_tags){ tags }
      end

      it 'passes the tags to a presenter' do
        expect( TagsPresenter )
          .to receive(:new).once
          .with( tags: tags, view_context: view_context )
          .and_return{ presenter }

        expect( presenter )
          .to receive(:to_html).once

        execution.call
      end
    end

  end

end
