require_relative 'spec_helper'

describe 'Viewing a persons forecasts' do

  context 'as superuser' do

    let(:super_user ){ create(:super_user) }
    let(:membership1){ create(:membership) }
    let(:duration   ) do
      Duration.create(
              durable: membership1,
            starts_at: '2015-02-01',
              ends_at: '2015-03-01',
           quantifier: 5,
        )
    end

    before(:each) do
      login_as(super_user, scope: :user)
    end


    context 'with a simple duration' do
      before(:each) do
        duration
      end
      it 'shows the person occupation periods'do
        visit forecasts_path(start_date: "2015-01-01")
        within the('forecasts-list') do
          expect( page ).to have_css( "#membership_#{membership1.id} td", text: "5", count: 3 )
        end
      end
    end

    context 'with a duration having no quantifier' do
      before(:each) do
        duration.update( quantifier: nil )
      end
      it "shows the occupation periods market with a em-dash '—'"do
        visit forecasts_path(start_date: "2015-01-01")
        within the('forecasts-list') do
          expect( page ).to have_css( ".occupation", text: "—", count: 3 )
        end
      end
    end

    context 'with a duration having no end_date' do
      before(:each) do
        duration.update( ends_at: nil )
      end
      it 'shows all future periods as occupied'do
        visit forecasts_path(start_date: "2015-01-01")
        within the('forecasts-list') do
          expect( page ).to have_css( ".occupation", text: "5", count: 10 )
        end
      end
    end

    context 'with a duration having no start_date' do
      before(:each) do
        duration.update( starts_at: nil )
      end
      it 'shows all past periods as occupied'do
        visit forecasts_path(start_date: "2015-01-01")
        within the('forecasts-list') do
          expect( page ).to have_css( ".occupation", text: "5", count: 5 )
        end
      end
    end

    context 'with overlapping durations' do
      before(:each) do
        duration
        duration2 = duration.dup
        duration2.update(starts_at: '2015-02-16', ends_at: '2015-05-01', quantifier: 2)
      end
      it 'shows the overlapping occupations'do
        visit forecasts_path(start_date: "2015-01-01")
        within the('forecasts-list') do
          expect( page ).to have_css( ".occupation"        , text: "5"  , count: 3 )
          expect( page ).to have_css( ".occupation"        , text: "2"  , count: 6 )
          expect( page ).to have_css( "td:has(.occupation)", text: "5 2", count: 2 )
        end
      end
    end


  end

end
