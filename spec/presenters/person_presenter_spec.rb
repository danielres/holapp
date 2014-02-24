require 'spec_helper'
require 'view_context_spec_helper'

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
      it "exposes the project membership form" do
        pending 'todo'
      end
      context 'when the person is already a member' do
        it "displays the memberships" do
          pending 'todo'
        end
      end
      end
  end

end
