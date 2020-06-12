class DatepickerWithTimeInput
  include ::Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      label_html << date_field << time_html_input
    end
  end

  def date_field
    builder.date_field(method, input_html_options)
  end

  def input_html_options
    super.merge(:class => "datetime")
  end

  def time_html_input
    builder.template.time_field(method, input_html_options)
  end
end

