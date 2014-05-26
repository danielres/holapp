class EvilCycleValidator < ActiveModel::Validator
  def validate(record)
    if record.taggable_type == 'Tag' and record.tag.present? and record.tag.ancestors.include?(record.taggable)
      record.errors[:base] << 'Cannot create tag(s): a circular tagging was detected.'
    end
  end
end

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  validates_with EvilCycleValidator, on: :create
end

