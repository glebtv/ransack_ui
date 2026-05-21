# frozen_string_literal: true

require 'ransack/adapters/active_record/context'

module Ransack
  module Adapters
    module ActiveRecord
      Context.class_eval do
        def type_for(attr)
          return nil unless attr&.valid?

          table = table_name_for(attr)
          raise "No table named #{table} exists." unless table_exists?(table)

          column = attr.klass.columns.find { |c| c.name == attr.arel_attribute.name.to_s }
          column.type
        end

        def table_name_for(attr)
          relation = attr.arel_attribute.relation
          relation.respond_to?(:table_name) ? relation.table_name : relation.name
        end

        def table_exists?(table)
          klass.connection.schema_cache.send(:data_source_exists?, table)
        end
      end
    end
  end
end
