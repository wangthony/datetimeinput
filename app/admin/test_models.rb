ActiveAdmin.register TestModel do
  actions :all, except: :show
  permit_params :datetime

  index do
    id_column
    column :datetime do |obj|
      obj.datetime&.strftime('%c %Z %z')
    end
    column :created_at do |obj|
      obj.created_at&.strftime('%c %Z %z')
    end
    column :updated_at do |obj|
      obj.updated_at&.strftime('%c %Z %z')
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :datetime, as: :datepicker_with_time
    end

    f.actions
  end
end
