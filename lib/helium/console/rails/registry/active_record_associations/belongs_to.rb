Helium::Console.define_formatter_for 'ActiveRecord::Associations::BelongsToAssociation' do
  def render_compact
    return format(object.target, :compact) if object.loaded?

    [
      light_magenta('one'),
      format(object.reflection.klass, :compact)
    ].join(' ')
  end

  def render_inline
    return format(object.target, :inline) if object.loaded?

    [
      light_magenta('one'),
      format(object.reflection.klass, :compact),
      "(#{light_blue primary_key}: #{format foreign_key_value})"
    ].join(' ')
  end

  def render_full
    [
      format(object.owner, :compact),
      light_magenta('belongs to'),
      light_blue(object.reflection.name.to_s),
      light_magenta('association'),
    ].join(' ')
  end

  private

  def primary_key
    object.reflection.association_primary_key
  end

  def foreign_key_value
    object.owner[object.reflection.foreign_key]
  end
end
