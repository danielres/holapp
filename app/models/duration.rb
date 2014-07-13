class Duration < ActiveRecord::Base
  belongs_to :durable, polymorphic: true


  def to_s
    name
  end

  def name
    "#{ durable && durable.name } #{ durable && durable.class.name.downcase } duration".strip
  end

end
