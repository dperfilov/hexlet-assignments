# frozen_string_literal: true

require_relative 'model'
require 'date'

class Post
  include Model
  self.extend(Model)


  # создаем переменные экземляра на основе переданного хеша (по умолчанию - пустой хэш)
  def initialize(attributes = {})
    @attributes = attributes

    attributes.each do |key, value|
      value = convert_value_type(value, get_attr_type(key))
      instance_variable_set("@#{key}", value)
    end
  end

  def attributes
    result = {}
    @attributes.each do |key, value|
      result[key] = convert_value_type(value, get_attr_type(key))
    end

    result
  end


  attribute :id, type: :integer
  attribute :title, type: :string
  attribute :body, type: :string
  attribute :created_at, type: :datetime
  attribute :published, type: :boolean



  # метод конвертации типов данных
  private 
  def convert_value_type(value, type)
    if type == :integer
      if !value.is_a?(Integer)
        value = value.to_i
      end
    elsif type == :string
      if !value.is_a?(String)
        value = value.to_s
      end
    elsif type == :datetime
      if !value.is_a?(DateTime)
        value = DateTime.parse(value)
      end
    elsif type == :boolean
      if !value.is_a?(TrueClass) && !value.is_a?(FalseClass)
        value = true if value.downcase == "true" || value == "1" || value == 1
      end
    end

    value
  end
end
