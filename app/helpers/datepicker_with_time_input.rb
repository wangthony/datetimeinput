class DatepickerWithTimeInput
	include ::Formtastic::Inputs::Base

	def to_html
		# setting virtual fields
		init_values

		# .gsub('li', 'span') - this is a limitation of formtastic gem
		value =
		datepicker_html.gsub('li', 'span').html_safe <<
		time_html.gsub('li', 'span').html_safe <<
		time_zone_html.gsub('li', 'span').html_safe <<
		hidden_html.gsub('li', 'span').html_safe

		template.content_tag(:li,
			[value, error_html, hint_html].join("\n").html_safe,
			wrapper_html_options
		)
	end

	def datepicker_html
		ActiveAdmin::Inputs::DatepickerInput.new(builder, template, object, object_name, "#{method}_date", default_datepicker_options.merge(options[:datepicker_options] || {})).to_html
	end

	def time_html
		Formtastic::Inputs::SelectInput.new(builder, template, object, object_name, "#{method}_time", default_time_options.merge(options[:time_select_options] || {})).to_html
	end

	def time_zone_html
		Formtastic::Inputs::HiddenInput.new(builder, template, object, object_name, "#{method}_tz", (options[:time_zone_options] || {})).to_html
	end

	def hidden_html
		Formtastic::Inputs::HiddenInput.new(builder, template, object, object_name, method, (options[:hidden_options] || {})).to_html
	end

	def default_time_options
		{
			label: false,
			wrapper_html: {class: 'datepicker_with_time'},
			collection: (0..23).map {|h| (0..59).select {|m| m % 5 == 0 }.map {|m| ['%02i' % h, '%02i' % m].join(':') } }.flatten
		}
	end

	def default_datepicker_options
		{
			wrapper_html: {class: 'datepicker_with_time'}
		}
	end

	def init_values
		value = object.send(method)
		object.send("#{method}=", value.in_time_zone(options[:time_zone] ? options[:time_zone] : 'UTC')) if value && options[:time_zone]

		object.class_eval <<-CODE
			define_method(:#{method}_buffer) do
				@#{method}_v ||= begin
					#{method}.try(:in_time_zone, '#{options[:time_zone] ? options[:time_zone] : 'UTC' }')
				end
			end

			define_method(:#{method}_tz) do
				#{method}_buffer.try(:strftime, '%z')
			end

			define_method(:#{method}_date) do
				#{method}_buffer.try(:strftime, '%Y-%m-%d')
			end

			define_method(:#{method}_time) do
				#{method}_buffer.try(:strftime, '%R')
			end
		CODE
	end
end
