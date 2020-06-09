class DatepickerWithTimeInput
  include ::Formtastic::Inputs::Base
  
  

  def to_html
    input_wrapping do
      label_html << builder.datetime_local_field(method, input_html_options) + time_zones 
    end
  end

  def time_zones
    builder.select(method, zones_collection, input_options, input_html_options)
  end

  def zones_collection
    ActiveSupport::TimeZone::MAPPING  
  end
end
