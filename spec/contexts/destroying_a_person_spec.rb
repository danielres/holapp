require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe DestroyingAPerson do

  context 'given a user and a person' do
    subject{ described_class.new(user, person)  }
    let(:user){ build(:no_roles_user) }
    let(:person){ create(:person) }
    let(:execution){ ->{ subject.execute } }
    let(:authorization){ ->{ allow(user).to receive( :can_destroy_resource? ){ true } } }

    describe 'execution' do

      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
        it 'destroys the person' do
          expect{ execution.call }
            .to change{ User.count }
            .from(1)
            .to(0)
        end
        describe 'handling related associations' do
          context "with memberships" do
            before{ Membership.create(person: person)  }
            it 'destroys related memberships' do
              expect{ execution.call }
                .to change{ Membership.count }
                .from(1)
                .to(0)
            end
          end
          context "with taggings" do
            before{ Tagging.create(taggable_id: person.id, taggable_type: 'User')  }
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
