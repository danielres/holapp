describe Support::PresenterHelpers do

  include Support::PresenterHelpers

  describe '#domain_language' do
    it 'translates technical terms to friendly domain terms' do
      expect( domain_language('User') ).to eq 'Person'
    end
  end

end

