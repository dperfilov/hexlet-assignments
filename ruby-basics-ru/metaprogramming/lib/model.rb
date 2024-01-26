# frozen_string_literal: true

module Model
  # геттеры и сеттеры 
  def attribute(name, options = {})
    define_method name do
       self.instance_variable_get("@#{name}")
      #return convert_value_type(value, options[:type])
    end

    define_method "#{name}=" do |value|
      # преобразование значения атрибута в тип, указанный в опциях (в хэше)
      value = convert_value_type(value, options[:type])

      # добавляем значение в хэш атрибутом, чтобы его можно было вернуть на чтение
      @attributes[name] = value

      self.instance_variable_set("@#{name}", value)
    end
  end

	# сопоставление названий переменный и их типов
	def get_attr_type(attr_name)
		attr_type_map = {
			id: :integer,
			title: :string,
			body: :string,
			created_at: :datetime,
			published: :boolean
		} 

		attr_type_map[attr_name]
	end
end