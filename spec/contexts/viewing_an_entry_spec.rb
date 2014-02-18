require 'spec_helper'
require 'view_context_spec_helper'

def build_entry(type)
  case type.name
  when 'Project'  then Project.new(name: 'Project name')
  when 'User'     then User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'User name')
  end
end

describe ViewingAnEntry do

  let(:view_context){ view }

  describe 'initialization' do

    [ Project, User ].each do |entry_type|

      before(:each){ allow(entry_type).to receive(:tag_fields) }

      context "given a viewer, a view_context and a #{entry_type.name.downcase}" do
        let(:viewer){ User.new }
        let(:entry){ entry_type.new }
        it 'initializes correctly' do
          described_class.new(viewer, view_context, entry)
        end
      end

      describe "viewing a #{entry_type.name.downcase}" do

        let(:subject){ described_class.new(viewer, view_context, entry)  }
        let(:entry){ build_entry(entry_type) }

        context 'as a guest viewer' do
          let(:viewer){ User.new }
          it "does not reveal the #{entry_type.name.downcase}" do
            expect( subject.view ).not_to include "#{entry_type} name"
          end
        end

        context 'as an authorized viewer' do
          let(:any_authorized_role){ :admin }
          let(:viewer){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
          it "reveals the entry" do
            expect( subject.view ).to include "#{entry_type} name"
          end
        end

      end
    end

  end


end
