ActiveAdmin.register TestModel do
  actions :all, except: :show

  index do
    id_column
    column :datetime do |obj|
      obj.datetime&.strftime('%c %Z %z')
    end
    column :date
    column :time
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
      f.input :datetime, as: :datepicker_with_time, time_zone: 'America/New_York'
      f.input :date, as: :datepicker
      f.input :time, as: :select, collection: (0..23).map {|h| (0..59).select {|m| m % 5 == 0 }.map {|m| ['%02i' % h, '%02i' % m].join(':') } }.flatten
    end

    f.actions
  end

  permit_params :datetime
end
