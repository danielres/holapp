require 'spec_helper'

describe AddingAPerson do

  describe 'adding a person' do
    let(:adding){ described_class.new(adder, person_attributes)  }
    let(:person_attributes) do
      { name: 'Toto', email: 'any@email.com', password: rand }
    end
    before(:each) do
      adding.add
    end
    context 'as a guest user' do
      let(:adder){ User.new }
      it 'does not add the person' do
        expect( User.last.try(:name) ).not_to eq 'Toto'
      end
    end
    context 'as an authorized adder' do
      let(:any_authorized_role){ :admin }
      let(:adder){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
      it 'adds the person' do
        expect( User.last.try(:name) ).to eq 'Toto'
      end
    end
  end

end
