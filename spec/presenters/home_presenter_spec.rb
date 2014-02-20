require 'spec_helper'

describe HomePresenter do

  let(:view_context){ double('view_context') }
  let(:viewer){ double('viewer') }

  describe 'Initialization' do
    context 'given a viewer and a view_context' do
      it 'initializes correctly' do
        described_class.new(viewer, view_context)
      end
    end
  end

  describe 'Rendering to html' do
    let(:home_presenter){ described_class.new(viewer, view_context) }
    let(:having_a_global_view){ double }
      it 'includes the global view' do
        expect( HavingAGlobalView ).to receive(:new)
                                   .with(viewer, view_context)
                                   .and_return{ having_a_global_view }
        expect( having_a_global_view ).to receive(:view)
        home_presenter.to_html
      end

  end

end
