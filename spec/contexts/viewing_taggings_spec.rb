require 'spec_helper'
require 'factories_spec_helper'

describe ViewingTaggings do
  let(:user){ build(:no_roles_user) }
  subject{ described_class.new(user, taggable)  }

  describe 'viewing a persons taggings on skills' do
    let(:taggable){ create(:person) }
    let(:view_context){ double('view_context') }

    context 'for guest users' do
      let(:user){ build(:no_roles_user) }
      it 'is not exposed' do
        expect( view_context ).not_to receive(:render)
        subject.expose_list(:skills, view_context)
      end
    end

    context 'for super users' do
      let(:user){ create(:super_user) }
      it 'is exposed' do
        expect( view_context ).to receive(:render).with( hash_including locals: { tag_field: :skills,  taggings: anything } )
        subject.expose_list(:skills, view_context)
      end
    end

  end

end
