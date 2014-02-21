require 'spec_helper'
require 'view_context_spec_helper'

describe AddingAPerson do

    let(:view_context){ view }

    let(:adding_a_person){ described_class.new(adder, view_context, person_attributes)  }
    let(:person_attributes){ { name: 'Toto'} }


    context 'as a guest user' do

      let(:adder){ User.new }

      describe 'exposing the form' do
        it 'does not render the form' do
          node = Capybara.string(adding_a_person.expose_form)
          expect( node ).not_to have_css 'form.new_user'
        end
      end


      describe 'adding a person' do
        it 'does not add the person' do
          adding_a_person.add
          expect( User.last.try(:name) ).not_to eq 'Toto'
        end
      end
    end


    context 'as an authorized adder' do

      let(:any_authorized_role){ :admin }
      let(:adder){ User.new.tap{ |u| u.add_role(any_authorized_role) } }

      describe 'exposing the form' do
        it 'renders the form' do
          node = Capybara.string(adding_a_person.expose_form)
          expect( node ).to have_css 'form.new_user'
        end
      end

      describe 'adding a person' do
        context "given only the person's name" do
          it 'adds the person' do
            adding_a_person.add
            expect( User.last.try(:name) ).to eq 'Toto'
          end
        end
      end

    end


end
