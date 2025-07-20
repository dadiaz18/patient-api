class AdherenceCalculator
  INJECTION_FREQUENCY = 3

  def initialize(patient)
    @patient = patient
  end

  def call
    expected_dates = generate_expected_dates
    return 0.0 if expected_dates.empty?

    actual_dates = @patient.injections.pluck(:created_at).map(&:to_date)
    on_time_injections = expected_dates.count { |date| actual_dates.include?(date) }

    (on_time_injections.to_f / expected_dates.size * 100).round(2)
  end

  private

  def generate_expected_dates
    start_date = @patient.created_at.to_date
    end_date = Date.today

    dates = []
    current_date = start_date

    while current_date < end_date
      dates << current_date
      current_date += INJECTION_FREQUENCY
    end

    dates
  end
end
