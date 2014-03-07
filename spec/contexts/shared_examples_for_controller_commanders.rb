shared_examples 'a controller commander' do

    let(:controller){ double('controller') }
    before(:each){ subject.command(controller) }
    describe 'on success' do
      it 'triggers controller#success' do
        allow( user ).to receive(:success?){ true }
        expect( controller ).to receive(:success)
        perform.call
      end
    end
    describe 'on failure' do
      it 'triggers controller#failure' do
        allow( user ).to receive(:success?){ false }
        expect( controller ).to receive(:failure)
        perform.call
      end
    end

end
