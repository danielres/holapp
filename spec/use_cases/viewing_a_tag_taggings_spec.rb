require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples/contexts'

describe ViewingATagTaggings, '- viewing taggings from the tag side' do
  subject{ described_class.new(user, tag).view_context(view_context) }
  let(:user){ build(:no_roles_user) }
  let(:tag){ build(:tag) }
  let(:view_context){ double('view_context') }

  include_examples 'a context'

  context 'when authorized' do

    before { authorization.call }

    let(:taggings){ [tagging_on_person, tagging_on_project1, tagging_on_project2] }
    let(:tagging_on_person  ){ mock_model( 'Tagging', taggable_type: 'Person',  context: :skills ) }
    let(:tagging_on_project1){ mock_model( 'Tagging', taggable_type: 'Project', context: :needs  ) }
    let(:tagging_on_project2){ mock_model( 'Tagging', taggable_type: 'Project', context: :needs  ) }

    before(:each) do
      subject.collection = taggings
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

      subject.call
    end
  end

end

