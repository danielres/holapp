require 'spec_helper'

describe HomePresenter do

  let(:view_context){ double('view_context').as_null_object }
  let(:viewer){ double('viewer').as_null_object }

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
    let(:adding_a_person){ double }
      it 'exposes a global view' do
        expect( HavingAGlobalView ).to receive(:new)
                                   .with(viewer, view_context)
                                   .and_return{ having_a_global_view }
        expect( having_a_global_view ).to receive(:view)
        home_presenter.to_html
      end
      it 'exposes a form to add a person' do
        expect( AddingAPerson ).to receive(:new)
                                   .and_return{ adding_a_person }
        expect( adding_a_person ).to receive(:expose_form)
        home_presenter.to_html
      end

  end

end
