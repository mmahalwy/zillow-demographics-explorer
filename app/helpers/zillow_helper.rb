module ZillowHelper
  def attribute_cell(attribute, nation = false)
    has_nation = attribute.try(:[], :values).try(:[], :nation)

    return if nation && has_nation.nil?

    scope = nation && has_nation ? :nation : :city

    value = attribute.try(:[], :value) ||
            attribute.try(:[], :values).try(:[], scope).try(:[], :value) ||
            attribute.try(:[], :values).try(:[], scope).try(:[], :value).try(:[], :_content_)

    value = value.try(:[], :_content_) if value.is_a?(Hash)
    return number_to_percentage(value.to_f * 100, precision: 2) if percentage?(attribute, scope)
    return number_to_currency(value) if currency?(attribute, scope)
    value
  end

  def type(attribute, scope)
    attribute.try(:[], :type) ||
    (attribute.try(:[], :value).is_a?(Hash) && attribute.try(:[], :value).try(:[], :type)) ||
    (attribute.try(:[], :values).try(:[], scope).try(:[], :value).is_a?(Hash) &&
    attribute.try(:[], :values).try(:[], scope).try(:[], :value).try(:[], :type))
  end

  def percentage?(attribute, scope)
    type(attribute, scope) == 'percent'
  end

  def currency?(attribute, scope)
    attribute.try(:[], :currency) ||
    (attribute.try(:[], :value).is_a?(Hash) && attribute.try(:[], :value).try(:[], :currency)) ||
    (attribute.try(:[], :values).try(:[], scope).try(:[], :value).is_a?(Hash) &&
    attribute.try(:[], :values).try(:[], scope).try(:[], :value).try(:[], :currency)) ||
    type(attribute, scope) && type(attribute, scope) != 'percent'
  end
end
