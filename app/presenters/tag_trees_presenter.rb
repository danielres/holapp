class TagTreesPresenter < Erector::Widget

  needs :tag, :view_context

  include Support::PresenterHelpers

  def content
    tag_trees(@tag)
  end

  private

    def poles(tag)
      Array( tag.pole? ? tag : tag.parents.map{|p| poles(p) } ).flatten
    end

    def tag_trees tag
      trees = []
      poles(tag).each do |p|
        trees << capture_content do
          panel do
            ul do
              tag_tree_branch(p)
            end
          end
        end
      end
      trees.uniq! # eliminate identical trees
      rawtext trees.join
    end

    def tag_tree_branch(tag)
      li do
        if tag == @tag
          strong{ u link_to tag.name, tag }
        else
          text link_to tag.name, tag
        end
        if tag.children.any?
          ul do
            tag
              .children
              .sort{|a,b| a.name <=> b.name }
              .each do |t|
                tag_tree_branch(t)
            end
          end
        end
      end
    end

end
