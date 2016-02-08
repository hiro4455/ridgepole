require 'active_record/connection_adapters/abstract_mysql_adapter'

module Ridgepole
  module Ext
    module AbstractMysqlAdapter
      def add_index(table_name, column_name, options = {})
        index_name, index_type, index_columns, index_options, index_algorithm, index_using = add_index_options(table_name, column_name, options)

        # cannot specify index_algorithm
        execute "ALTER TABLE #{quote_table_name(table_name)} ADD #{index_type} INDEX #{quote_column_name(index_name)} #{index_using} (#{index_columns})#{index_options}"
      end

      def remove_index!(table_name, index_name)
        execute "ALTER TABLE #{quote_table_name(table_name)} DROP INDEX #{quote_column_name(index_name)}"
      end
    end
  end
end

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      prepend Ridgepole::Ext::AbstractMysqlAdapter
    end
  end
end
