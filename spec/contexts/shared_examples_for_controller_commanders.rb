require_relative 'shared_context_by_an_authorized_user'

shared_examples 'a controller commander' do |success_message, failure_message|

    success_message ||= :success
    failure_message ||= :failure

    let(:controller){ double('controller') }
    before(:each){ subject.command(controller) }

    describe 'commanding the controller' do

      context 'with a basic user' do
        let(:user){ build(:no_roles_user) }
        it 'is forbidden' do
          expect{ execution.call }.to raise_error ActionForbiddenError
        end
      end

      context 'with an authorized user' do
        include_context 'by an authorized user'
        describe 'on success' do
          it "triggers controller##{ success_message }" do
            allow( user ).to receive(:success?){ true }
            expect( controller ).to receive(success_message)
            execution.call
          end
        end
        describe 'on failure' do
          it "triggers controller##{ failure_message }" do
            allow( user ).to receive(:success?){ false }
            expect( controller ).to receive(failure_message)
            execution.call
          end
        end
      end

    end

end
