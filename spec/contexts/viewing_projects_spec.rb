require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_context_by_an_authorized_user'

describe ViewingProjects do
  subject{ described_class.new(user) }
  let(:view_context){ double('view_context') }
  let(:execution){ ->{ subject.expose_list(view_context) } }

   describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'

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
          .with( projects, view_context )
          .and_return{ presenter }

        expect( presenter )
          .to receive(:to_html).once

        execution.call
      end
    end

  end

end
