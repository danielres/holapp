require 'spec_helper'
require 'factories_spec_helper'
require_relative '../shared_examples/contexts'

describe News::ReceivingADigestEmail do
  subject{ described_class.new(user) }
  let(:user){ create(:super_user) }

  include_examples 'a context'


  context 'when authorized' do

    before{ authorization.call }

    context 'when the recipient has opted in' do
      context 'with news items to send' do
        it 'triggers the mailing of the digest' do
          expect( News::Mailer )
            .to receive(:digest_email).once
            .with( user, anything)
            .and_call_original
          subject.call
        end
      end
      context 'with no news items to send' do
        it 'sends an email informing the user of the absence of news'
      end
    end

    context 'when the recipient has opted out' do
      context 'with news items to send' do
        it 'does not trigger the mailing of the digest'
      end
    end
  end

end
