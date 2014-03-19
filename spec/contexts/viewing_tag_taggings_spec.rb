require 'spec_helper'
require 'factories_spec_helper'

describe ViewingTagTaggings do

  let(:user){ build(:no_roles_user) }
  subject{ described_class.new(user, tag)  }

  describe 'viewing taggables from a tag' do
    let(:tag){ create(:tag, name: 'my_tag') }
    let(:person1){ create(:person) }
    let(:project1){ create(:project) }
    let(:project2){ create(:project) }
    let(:view_context){ double('view_context') }

    context 'for guest users' do
      let(:user){ build(:no_roles_user) }
      it 'is forbidden' do
        expect( view_context ).not_to receive(:render)
        expect{ subject.expose_grouped_lists(view_context) }.to raise_error
      end
    end

    context 'for super users' do
      let!(:tagging1){ Tagging.create!( tag_id: tag.id, taggable_type: person1.class.name, taggable_id: person1.id, context: :skills ) }
      let!(:tagging2){ Tagging.create!( tag_id: tag.id, taggable_type: project1.class.name, taggable_id: project1.id, context: :needs ) }
      let!(:tagging3){ Tagging.create!( tag_id: tag.id, taggable_type: project2.class.name, taggable_id: project2.id, context: :needs ) }
      let(:user){ create(:super_user) }
      it 'invokes rendering of taggings, grouped by their taggable types' do
        expect( view_context ).to receive(:render).twice do |options|
          if options[:locals][:type] == 'User'
            expect( options[:locals][:taggings] ).to match_array [ tagging1 ]
          end
          if options[:locals][:type] == 'Project'
            expect( options[:locals][:taggings] ).to match_array [ tagging2, tagging3 ]
          end
        end
        subject.expose_taggings_by_taggable_types(view_context)
      end
    end

  end

end
