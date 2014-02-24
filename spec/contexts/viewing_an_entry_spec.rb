# require 'spec_helper'
# require 'view_context_spec_helper'

# def build_entry(type)
#   case type.name
#   when 'Project'  then Project.new(name: 'Project name')
#   when 'User'     then User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'User name')
#   end
# end

# describe ViewingAnEntry do

#   let(:view_context){ view }

#   describe 'initialization' do

#     [ Project, User ].each do |data_object_class|

#       before(:each) do
#         allow(data_object_class).to receive(:tag_fields)
#       end

#       context "given a viewer, a view_context and a #{data_object_class.name.downcase}" do
#         let(:viewer){ User.new }
#         let(:entry){ data_object_class.new }
#         it 'initializes correctly' do
#           described_class.new(viewer, view_context, entry)
#         end
#       end

#       describe "viewing a #{data_object_class.name.downcase}" do

#         let(:subject){ described_class.new(viewer, view_context, entry)  }
#         let(:entry){ build_entry(data_object_class) }

#         context 'as a guest viewer' do
#           let(:viewer){ User.new }
#           it "does not reveal the #{data_object_class.name.downcase}" do
#             expect( subject.view ).not_to include "#{data_object_class} name"
#           end
#         end

#         context 'as an authorized viewer' do
#           let(:any_authorized_role){ :admin }
#           let(:viewer){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
#           it "reveals the entry" do
#             expect( subject.view ).to include "#{data_object_class} name"
#           end

#           describe "when #{ data_object_class.name.downcase } has been tagged" do
#             before(:each) do
#               superuser =  User.new.tap{ |u| u.add_role(:admin) }
#               TaggingAnEntry.new(superuser, entry, "tag1, tag2", :customs).tag
#             end
#             it 'displays the taggings' do
#               expect( subject.view ).to include "tag1"
#               expect( subject.view ).to include "tag2"
#             end
#           end

#         end

#       end
#     end

#   end


# end
