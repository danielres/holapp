class FeaturesProfile
  def self.feature? feature
    features[feature].present?
  end

  private
    def self.features
      {
        projects: false,
        memberships: false,
        forecasts: false,
        tags: true,
        edit_account: false,
        cvs: false,
      }
    end
end
