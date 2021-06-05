if defined? ActiveRecord
  Helium::Console.define_formatter_for ActiveRecord::Relation do
    def call
      # primary_key = object.class.primary_key

      table = Helium::Console::Table.new(runner: "  ", after_key: ": ", format_keys: false)
      formatted = object.map { |record| format_record(record) }
      [
        ["#", object.klass.name, "relation (#{object.size} element#{:s if object.size > 1})"].join(" "),
        formatted.join("#{$/}|#{$/}")
      ].join($/)
    end

    def format_record(record)
      table = Helium::Console::Table.new(runner: '| ', after_key: ": ", format_keys: false)
      table.row(primary_key, record.attributes[primary_key]) if primary_key

      record.attributes.sort_by(&:first).each do |key, value|
        next if key == primary_key
        table.row(key.to_s, value)
      end

      format(table, **options, max_width: max_width - 2)
    end

    def primary_key
      object.klass.primary_key
    end
  end
end
