require 'spec_helper'
require 'view_context_spec_helper'

def build_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end

describe PeoplePresenter do

  describe 'initialization' do
    context 'given a collection and a view_context' do
      let(:people){ [] }
      it 'initializes correctly' do
        described_class.new(people, view_context)
      end
    end
  end

  describe 'rendering to html' do
    context 'given people' do
      let(:person1){ build_random_person name: 'person_A' }
      let(:person2){ build_random_person name: 'person_B' }
      let(:people){ [ person1, person2] }
      let(:people_presenter){ described_class.new(people, view_context) }
      it 'renders html with the people' do
        expect( people_presenter.as_html ).to include 'person_A'
        expect( people_presenter.as_html ).to include 'person_B'
      end
    end
  end


end
