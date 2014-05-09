require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'

describe ViewingProjects do
  subject{ described_class.new(user) }
  let(:user){ build(:no_roles_user) }
  let(:view_context){ double('view_context') }
  let(:execution){ ->{ subject.expose_list(view_context) } }
  let(:authorization){ ->{ allow(user).to receive( :can_view_projects? ){ true } } }

   describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end

      let(:projects){ [project1, project2] }
      let(:project1){ build(:project) }
      let(:project2){ build(:project) }
      let(:presenter){ double('presenter') }

      before(:each) do
        expect(user).to receive(:available_projects){ projects }
      end

      it 'passes the projects a presenter' do
        expect( ProjectsPresenter )
          .to receive(:new).once
          .with( projects: projects, view_context: view_context )
          .and_return{ presenter }

        expect( presenter )
          .to receive(:to_html).once

        execution.call
      end
    end

  end

end
