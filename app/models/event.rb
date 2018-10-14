class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :occurance_date, presence: true

  scope :active, -> { where(active: true) }

  def self.interval_types
    %i[singular daily weekly monthly yearly]
  end

  # retrieves occurrences for array of events
  def self.occurrences_between(events, period_from, period_to)
    result =
      events.map do |event|
        event.occurrences(period_from, period_to)
      end

    result.flatten.sort_by! { |occ| occ[:occurance_date] }
  end

  # retrieves occurrences for event instance
  # returns array of hashs which will be used for calendar render
  def occurrences(period_from, period_to)
    schedule = IceCube::Schedule.from_hash(settings)
    occurances = schedule.occurrences_between(period_from, period_to)
    occurances.map do |occ_date|
      {
        id: id,
        title: title,
        user: user,
        occurance_date: occ_date
      }
    end
  end

  def build_shedule_settings
    repeat_rule = if repeat_interval.to_sym == :singular
                    IceCube::Rule.daily.count(1)
                  else
                    IceCube::Rule.send(repeat_interval)
                  end

    schedule = IceCube::Schedule.new(occurance_date)
    schedule.add_recurrence_rule(repeat_rule)

    self[:settings] = schedule.to_hash
  end
end
