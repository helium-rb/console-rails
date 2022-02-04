# frozen_string_literal: true

if defined? ActiveRecord
  Helium::Console.define_formatter_for ActiveRecord::Associations::HasOneThroughAssociation do
    def call
      return format(object.target) if object.loaded?

      through = object.reflection.through_reflection.name
      "#{light_magenta 'one'} #{format object.reflection.klass,
                                       short: true} #{light_magenta 'through'} #{format through}"
    end
  end

  Helium::Console.define_formatter_for ActiveRecord::Associations::HasOneAssociation do
    def call
      return format(object.target) if object.loaded?

      foreign_key = object.reflection.foreign_key
      pk_value = object.owner[object.reflection.association_primary_key]
      "#{light_magenta 'one'} #{format object.reflection.klass,
                                       short: true}(#{light_blue foreign_key}: #{format pk_value})"
    end
  end

  Helium::Console.define_formatter_for ActiveRecord::Associations::HasManyAssociation do
    def call
      return format(object.target) if object.loaded?

      foreign_key = object.reflection.foreign_key
      pk_value = object.owner[object.reflection.association_primary_key]
      "#{light_magenta 'many'} #{format object.reflection.klass,
                                        short: true}(#{light_blue foreign_key}: #{format pk_value})"
    end
  end

  Helium::Console.define_formatter_for ActiveRecord::Associations::HasManyThroughAssociation do
    def call
      return format(object.target) if object.loaded?

      through = object.reflection.through_reflection.name
      "#{light_magenta 'many'} #{format object.reflection.klass,
                                        short: true} #{light_magenta 'through'} #{format through}"
    end
  end

  Helium::Console.define_formatter_for ActiveRecord::Associations::BelongsToPolymorphicAssociation do
    def call
      return format(object.target) if object.loaded?
      return format(nil) if object.klass.nil?

      primary_key = object.klass.primary_key
      fk_value = object.owner[object.reflection.foreign_key]

      "#{light_magenta 'one'} #{format object.klass, short: true}(#{light_blue primary_key}: #{format fk_value})"
    end
  end

  Helium::Console.define_formatter_for ActiveRecord::Associations::Association do
    def call
      object.reflection.macro.to_s
    end
  end
end
