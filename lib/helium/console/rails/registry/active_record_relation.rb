if defined? ActiveRecord
  Helium::Console.define_formatter_for ActiveRecord::Relation do
    def call
      return format_loaded if object.loaded?

      if level == 1
        object.load
        format_loaded
      else
        format_unloaded
      end
    end

    def format_loaded
      [
        "# #{format(object.klass, short: true)} relation (#{object.size} element#{:s if object.size > 1})",
        format(object.to_a)[1..-1]
      ].join("\n")
    end

    def format_unloaded
      "# #{format(object.klass, short: true)} relation #{red('(not loaded)')}"
    end

    def primary_key
      object.klass.primary_key
    end
  end
end
