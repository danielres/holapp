require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_context_by_an_authorized_user'

describe ViewingATaggableTaggings, '- viewing taggings from the taggable side' do
  subject{ described_class.new(user, taggable)  }
  let(:taggable){ build(:person) }
  let(:tag_field){ :skills }
  let(:view_context){ double('view_context') }
  let(:execution){ ->{ subject.expose_list(tag_field, view_context) } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'

      let(:taggings){ [tagging1, tagging2] }
      let(:tagging1){ mock_model( 'Tagging', context: :skills ) }
      let(:tagging2){ mock_model( 'Tagging', context: :skills ) }

      let(:presenter){ double('presenter') }

      before(:each) do
        expect(user).to receive(:available_taggings){ taggings }
      end

      it 'passes the taggings, tag_field and view_context to a presenter' do
        expect( TaggingsPresenter )
          .to receive(:new).once
          .with( [tagging1, tagging2], :skills, view_context )
          .and_return{ presenter }

        expect( presenter )
          .to receive(:to_html).once
          .with(viewed_from: :taggable)

        execution.call
      end

    end

  end

end
