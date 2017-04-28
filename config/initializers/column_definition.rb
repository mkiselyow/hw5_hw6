class ActiveRecord::ConnectionAdapters::ColumnDefinition
  def sql_type
    if Rails.env.development?
      type.to_sym == :primary_key ? 'int(11) auto_increment PRIMARY KEY' : base.type_to_sql(type.to_sym, limit, precision, scale) rescue type
    end
  end 
end