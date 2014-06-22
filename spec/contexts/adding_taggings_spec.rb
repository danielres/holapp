require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples/contexts'
require_relative 'shared_examples/form_providers'

describe AddingTaggings do
  subject{ described_class.new(user, taggable, tag_list, tag_field)  }
  let( :taggable  ){ mock_model( [Project, Tag, User].sample ) }
  let( :tag_list  ){ 'tag1, tag2' }
  let( :tag_field ){ :skills }

  include_examples 'a context'
  include_examples 'a form provider'

  context 'when authorized' do

    before { authorization.call }

    it 'generates the tags from a comma-separated list' do
      expect( TagRepository )
        .to receive(:apply_tag_list_on)
        .with(tag_list, taggable, tag_field)
      subject.call
    end

  end

end
