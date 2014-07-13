class Journal
  def self.insert args
    Activity.create!(args)
  end
end

