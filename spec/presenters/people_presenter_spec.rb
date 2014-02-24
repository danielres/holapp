require 'spec_helper'
require 'view_context_spec_helper'

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
      let(:person1){ User.new(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_A') }
      let(:person2){ User.new(email: "foo2#{rand}@bar.com", password: 'password', name: 'person_B') }
      let(:people){ [ person1, person2] }
      let(:subject){ described_class.new(people, view_context) }
      it 'renders html with the people' do
        expect( subject.as_html ).to include 'person_A'
        expect( subject.as_html ).to include 'person_B'
      end
    end
  end


end
