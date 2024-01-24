# frozen_string_literal: true
require 'uri'
require 'forwardable'

class Url
	extend Forwardable
	include Comparable
	attr_reader :address, :uri, :query_params

	def_delegators :@uri, :scheme, :host, :port, :path

	def initialize(address)
		@address = address
		@uri = URI(address)
		@query_params = parse_query_params(uri.query) # возвращает параметры запроса в виде пар ключ-значение объекта
	end


	# принимает ключ и дефолтное значение (по-умолчанию оно равно nil). 
	# Если указанный ключ отсутствует в параметрах запроса, то возвращается дефолтное значение
	def query_param(key, *params)
		# задаем переменную default_value (nil если ничего не передано либо первый элемент массива)
		params.empty? ? default_value = nil : default_value = params.first

		query_params.key?(key) ? query_params[key] : default_value
	end

	# == (Через Comparable) — принимает объект класса Url и возвращает результат сравнения с текущим объектом — true или false
	def ==(other)
		scheme == other.scheme &&
		host == other.host &&
		port == other.port &&
		path == other.path &&
		query_params == other.query_params
	end


	private
	def parse_query_params(query_string)
		result = {}

		query_string.split('&').reduce(result) do |result, pair| # разбиваем строку параметров на пары ключ-значание
			 # разбиваем пару ключ-значение и добавляем в результат (аккумулятор)
			key, value = pair.split('=')
			result[key.to_sym] = value
			result
		end if query_string

		result
	end
end