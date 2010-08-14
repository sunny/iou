class NilValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil?
      record.errors[attribute] << (options[:message] || "should not be set") 
    end
  end
end

