require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe DestroyingATag do

  context 'given a user and a tag' do
    subject{ described_class.new(user, tag)  }
    let(:user){ build(:no_roles_user) }
    let(:tag){ create(:tag) }
    let(:execution){ ->{ subject.execute } }
    let(:authorization){ ->{ allow(user).to receive( :can_destroy_resource? ){ true } } }

    describe 'execution' do

      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
        it 'destroys the tag' do
          expect{ execution.call }
            .to change{ Tag.count }
            .from(1)
            .to(0)
        end
        describe 'handling related associations' do
          context "with taggings" do
            before{ Tagging.create(tag_id: tag.id)  }
            it 'destroys related taggings' do
              expect{ execution.call }
                .to change{ Tagging.count }
                .from(1)
                .to(0)
            end
          end
          context "with parent tags" do
            before{ Tagging.create(taggable_id: tag.id, taggable_type: 'Tag')  }
            it 'destroys related taggings' do
              expect{ execution.call }
                .to change{ Tagging.count }
                .from(1)
                .to(0)
            end
          end
        end
      end

      include_examples 'a controller commander', :destroy_success, :destroy_failure

    end

  end

end
