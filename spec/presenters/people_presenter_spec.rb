describe PeoplePresenter do


  let(:view_context){ double('view_context') }

  describe 'initialization' do
    context 'given a collection and a view_context' do
      let(:people){ [] }
      it 'initializes correctly' do
        described_class.new(people, view_context)
      end
    end

  end

  describe 'rendering to html using a template' do
    let(:rendered_template){ ERB.new("<%= people.inspect %>").result(binding) }
    context 'given people' do
      let(:person1){ double('person_1', name: 'person_1') }
      let(:person2){ double('person_2', name: 'person_2') }
      let(:people){ [ person1, person2] }
      let(:subject){ described_class.new(people, view_context) }
      before(:each) do
        allow(subject).to receive(:as_html){ rendered_template }
      end
      it 'passes the people to the template' do
        expect( subject.as_html ).to include 'person_1'
        expect( subject.as_html ).to include 'person_2'
      end
    end
    describe 'using view helpers' do
      # it 'supports using rails helpers' do
      #   pending "I don't know how to test it"
      # end
    end
  end


end
