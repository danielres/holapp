require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'

describe ViewingATagTaggings, '- viewing taggings from the tag side' do
    subject{ described_class.new(user, tag)  }
    let(:user){ build(:no_roles_user) }
    let(:tag){ build(:tag) }
    let(:view_context){ double('view_context') }
    let(:execution){ ->{ subject.expose_taggings_by_taggable_types(view_context) } }
    let(:authorization){ ->{ allow(user).to receive( :can_view_taggables? ){ true } } }

    describe 'execution' do
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end

        let(:taggings){ [tagging_on_person, tagging_on_project1, tagging_on_project2] }
        let(:tagging_on_person  ){ mock_model( 'Tagging', taggable_type: 'Person',  context: :skills ) }
        let(:tagging_on_project1){ mock_model( 'Tagging', taggable_type: 'Project', context: :needs  ) }
        let(:tagging_on_project2){ mock_model( 'Tagging', taggable_type: 'Project', context: :needs  ) }

        before(:each) do
          subject
          expect(tag).to respond_to(:taggings)
          allow(tag).to receive(:taggings){ taggings }
        end

        it 'passes the taggings to a presenter, grouped by taggable type and by tag fields' do
          expect( TagFieldWithTaggingsPresenter )
            .to receive(:new)
            .with( tag_field: :skills, taggings: [tagging_on_person], viewed_from: anything, view_context: anything )
            .and_return{ double.as_null_object }

          expect( TagFieldWithTaggingsPresenter )
            .to receive(:new)
            .with( tag_field: :needs, taggings: [tagging_on_project1, tagging_on_project2], viewed_from: anything, view_context: anything)
            .and_return{ double.as_null_object }

          execution.call
        end

      end

    end

  end

