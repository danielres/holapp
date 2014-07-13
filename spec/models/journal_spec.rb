describe Journal do
  describe 'inserting to the journal' do
    let(:journal_event){ {} }
    it 'creates an activity' do
      expect(Activity)
        .to receive(:create!)
        .with(journal_event)
      described_class.insert( journal_event )
    end
  end
end
