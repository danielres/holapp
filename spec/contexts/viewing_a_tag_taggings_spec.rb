require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_context_by_an_authorized_user'

describe ViewingATagTaggings, '- viewing taggings from the tag side' do
    subject{ described_class.new(user, tag)  }
    let(:tag){ build(:tag) }
    let(:view_context){ double('view_context') }
    let(:execution){ ->{ subject.expose_taggings_by_taggable_types(view_context) } }

    describe 'execution' do
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        include_context 'by an authorized user'

        let(:taggings){ [tagging_on_person, tagging_on_project1, tagging_on_project2] }
        let(:tagging_on_person  ){ mock_model( 'Tagging', taggable_type: 'Person',  context: :skills ) }
        let(:tagging_on_project1){ mock_model( 'Tagging', taggable_type: 'Project', context: :needs  ) }
        let(:tagging_on_project2){ mock_model( 'Tagging', taggable_type: 'Project', context: :needs  ) }

        let(:presenter){ double('presenter').as_null_object }

        before(:each) do
          expect(tag).to respond_to(:taggings)
          allow(tag).to receive(:taggings){ taggings }
        end

        it 'passes the taggings to a presenter, grouped by taggable type and by tag fields' do
          expect( TaggingsPresenter )
            .to receive(:new)
            .with( [tagging_on_person], :skills, anything )
            .and_return{ presenter }

          expect( TaggingsPresenter )
            .to receive(:new)
            .with( [tagging_on_project1, tagging_on_project2], :needs, anything)
            .and_return{ presenter }

          expect( presenter )
            .to receive(:to_html).twice
            .with(viewed_from: :tag)

          execution.call
        end

      end

    end

  end

