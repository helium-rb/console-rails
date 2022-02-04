# frozen_string_literal: true

Helium::Console.define_formatter_for ActiveSupport::TimeWithZone do
  def call
    "#{format object.time} #{blue "(#{object.time_zone.name})"}"
  end
end
