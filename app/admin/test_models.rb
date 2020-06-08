ActiveAdmin.register TestModel do
  form do |f|
    f.inputs do
      f.input :datetime, as: :datepicker_with_time
    end

    f.actions
  end
end
