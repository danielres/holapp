class PeoplePresenter < Erector::Widget

  needs :people, :view_context

  include Support::PresenterHelpers

  def content
    table the('people-list') do
      caption 'People'
      @people.sort{ |x,y| x.name <=> y.name }.each do |p|
        tr do
          td.name{ text @view_context.link_to p.name, p }
          td.description{ text p.description }
        end
      end
    end

  end

end
