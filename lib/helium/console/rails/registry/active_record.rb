# frozen_string_literal: true

Helium::Console.define_formatter_for 'ActiveRecord::Base' do
  def render_compact
    [
      light_black('#'),
      format(object.class, :compact),
      "(#{light_blue primary_key.to_s}: #{format object[primary_key], :compact, max_width: nil})"
    ].join
  end

  def render_partial
    table = Helium::Console::Table.new(runner: '| ', after_key: ': ', format_keys: false)

    attributes.each do |key, value|
      table.row(light_blue(key.to_s), value)
    end

    yield_lines do |y|
      y << "# #{format object.class, short: true}"
      format(table).lines.each { |line| y << line }
    end
  end

  private

  def attributes
    attrs = object.attributes.symbolize_keys

    primary_key = extract!(self.primary_key, from: attrs)
    timestamps = extract!(:created_at, :updated_at, from: attrs)
    associations = extract_associations(from: attrs)

    attrs.delete(inheritance_column) if attrs[inheritance_column] == object.class.name

    [
      *primary_key,
      *attrs.sort_by(&:first),
      *timestamps,
      *associations
    ]
  end

  def extract_associations(from:)
    object.class.reflect_on_all_associations
      .map(&:name)
      .sort
      .map { |name| [name.to_sym, object.association(name)] }
      .each do |_name, association|
        from.delete(association.reflection.foreign_key.to_sym) if association.reflection.belongs_to?
      end
  end

  def extract!(*keys, from:)
    keys
      .map { |key| [key, from.delete(key)] if from.key?(key) }
      .compact
  end

  def inheritance_column
    object.class.inheritance_column.to_sym
  end

  def primary_key
    object.class.primary_key.to_sym
  end
end
