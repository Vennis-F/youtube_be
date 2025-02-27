module V1::Helpers::SharedParamsHelper
  extend Grape::API::Helpers

  params :order do |options|
    optional :data_sort, type: Symbol, values: options[:data_sort], default: options[:default_data_sort]
    optional :order_sort, type: Symbol, values: %i[asc desc], default: options[:default_order_sort]
  end

end