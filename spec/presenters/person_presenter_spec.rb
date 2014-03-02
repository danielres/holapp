require 'spec_helper'
require 'view_context_spec_helper'
require 'fast_authentication_spec_helper'

def admin_user
  User.create!(email: "admin#{rand}@user.com", password: 'password', name: 'Admin#{rand}').tap do |u|
    u.confirm!
    u.add_role :admin
  end
end
def build_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end

describe PersonPresenter do

  describe 'initialization' do
    context 'given a viewer, person and a view_context' do
      let(:viewer){ double('viewer') }
      let(:person){ double('person') }
      it 'initializes correctly' do
        described_class.new(viewer, person, view_context)
      end
    end
  end

  describe 'rendering to html' do
    let(:viewer){ User.new }
    let(:person){ build_random_person name: 'Alfred' }
    let(:person_presenter){ described_class.new(viewer, person, view_context) }
    it "renders html containing the person's name" do
      expect( person_presenter.to_html ).to include 'Alfred'
    end
    describe "membership" do
      let(:viewer){ admin_user }
      context "when authenticated" do
        it "exposes the project membership form" do
          node = Capybara.string( person_presenter.to_html )
          expect( node ).to have_css("form.new_membership")
        end
        context 'when the person is already a project member' do
          let(:project){ Project.new(name: 'Project name') }
          before(:each) do
            person.projects << project
          end
          it 'displays the project' do
            expect( person_presenter.to_html ).to include 'Project name'
          end
        end
      end
    end
  end

end
