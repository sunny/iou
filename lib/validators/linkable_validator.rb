class LinkableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[\w_ -]+$/ and value !=~ /^[0-9]+$/
      record.errors[attribute] << (options[:message] || "should be made of letters") 
    end
  end
end

