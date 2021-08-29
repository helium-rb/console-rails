if defined? ActiveRecord
  Helium::Console.define_formatter_for ActiveRecord::Base do
    def call
      primary_key = object.class.primary_key

      table = Helium::Console::Table.new(runner: '| ', after_key: ": ", format_keys: false)
      table.row(primary_key, object.attributes[primary_key]) if primary_key

      object.attributes.sort_by(&:first).each do |key, value|
        next if key == primary_key
        table.row(key.to_s, value)
      end

      [
        "# #{format object.class, short: true}",
        format(table, **options)
      ].join($/)
    end
  end
end
