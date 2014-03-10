shared_examples 'a taggable' do

    describe 'tagging' do
      describe 'adding skills' do
        before(:each) do
          visit url_for(taggable)
        end
        it 'adds the skills to the taggable page' do
          within the("#{ tag_field }-adder") do
            fill_in :tagging_tag_list, with: 'tag1, tag2'
            first('[type=submit]').click
          end
          visit url_for(taggable)
          expect( page ).to have_content('tag1')
          expect( page ).to have_content('tag2')
        end
      end
    end

end
