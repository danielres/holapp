require 'spec_helper'

describe Project do

  describe "model attributes" do
    it 'has a unique name' do
      expect(subject).to validate_presence_of(:name)
      expect(subject).to validate_uniqueness_of(:name)
    end
    it 'can have a description' do
      expect(subject).to respond_to(:description)
    end
  end

end
