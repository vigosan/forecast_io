require 'ostruct'

module ForecastIO
  class Entity
    class InvalidAttribute < StandardError; end

    ATTRIBUTES = []

    def initialize(attrs={})
      attrs.each do |attr, value|
        raise InvalidAttribute unless valid_attribute?(attr)
        self.class.send(:attr_reader, attr)
        instance_variable_set("@#{attr}", to_value(value))
      end
    end

    def ==(other)
      self.class::ATTRIBUTES.all? { |attr| send(attr) == other.send(attr) }
    end

    private

    def valid_attribute?(attr)
      self.class::ATTRIBUTES.include?(attr.to_sym)
    end

    def to_value(value)
      return value unless value.is_a?(Hash)
      OpenStruct.new(value)
    end
  end
end
