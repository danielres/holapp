describe Support::PresenterHelpers do

  include Support::PresenterHelpers

  describe '#domain_language' do
    it 'translates technical terms to friendly domain terms' do
      expect( domain_language('User') ).to eq 'Person'
    end
  end
  describe '#pretty_quantifier' do
    it 'transforms a value from 0 to 5 to its graphical representation' do
      expect( pretty_quantifier(0) ).to eq '—'
      expect( pretty_quantifier(1) ).to eq '▮▯▯▯▯'
      expect( pretty_quantifier(2) ).to eq '▮▮▯▯▯'
      expect( pretty_quantifier(3) ).to eq '▮▮▮▯▯'
      expect( pretty_quantifier(4) ).to eq '▮▮▮▮▯'
      expect( pretty_quantifier(5) ).to eq '▮▮▮▮▮'
    end
  end

end

