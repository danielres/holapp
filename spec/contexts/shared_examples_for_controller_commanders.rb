shared_examples 'a controller commander' do |success_message, failure_message|

    success_message ||= :success
    failure_message ||= :failure

    let(:controller){ double('controller') }

    before(:each) do
      subject.command(controller)
    end

    describe 'commanding the controller' do

      context 'with a basic user' do
        it 'is forbidden' do
          expect{ execution.call }.to raise_error ActionForbiddenError
        end
      end

      context 'with an authorized user' do
        before(:each) do
          authorization.call
        end
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
