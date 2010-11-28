module ApplicationHelper
  def rails_msg(type)
    type = type.to_sym
    unless type == :alert || type == :notice
      raise ArgumentError, 'Can only handle alert and notice messages.'
    end

    return '' if send(type).blank?

    capture_haml do
      haml_tag("##{type}") do
        haml_concat send(type)
      end
    end
  end
end
