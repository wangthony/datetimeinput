class DatepickerWithTimeInput
  include ::Formtastic::Inputs::Base
  
  def to_html
    input_wrapping do
      label_html <<  builder.datetime_local_field(method, input_html_options) 
    end
  end
end
