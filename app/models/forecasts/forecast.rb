class Forecasts::Forecast

  def initialize(starting_from_month: DateTime.now, months: 5, periodicity: 'half-monthly')
    @starting_from_month = starting_from_month
    @months              = months
    @periodicity         = periodicity
  end

  def periods
    Period.starting_from_month(@starting_from_month, @months, @periodicity)
  end

  def self.periods
    Period.starting_from_month(DateTime.now)
  end


  private

    class Period
      attr_reader :starts_at
      attr_reader :ends_at

      def self.starting_from_month(date, months = 6, periodicity = 'half-monthly' )
        first_month_start = Date.parse(Time.new(date.year, date.month).to_s)
        periods = []
        months.times do |i|
          month_start  = first_month_start >> i
          month_end    = ((month_start >> 1) - 1)
          case periodicity
          when 'half-monthly'
            month_middle = month_start + 15
            periods << Period.new(month_start, (month_middle - 1))
            periods << Period.new(month_middle, month_end )
          when 'monthly'
            periods << Period.new(month_start, month_end)
          end
        end
        periods
      end

      def initialize start_date, end_date
        @starts_at = start_date
        @ends_at   = end_date
      end


      def membership_occupations(membership)
        durations = Duration.where(durable: membership)
        durations.map do |d|
          occupation(d)
        end
      end

      private

        def occupation(duration)
          return "" unless duration.starts_at || duration.ends_at
          return "" if duration.ends_at   && duration.ends_at.to_date   < starts_at
          return "" if duration.starts_at && duration.starts_at.to_date > ends_at
          duration.quantifier || '—'
        end

    end


end
