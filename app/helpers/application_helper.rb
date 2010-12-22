module ApplicationHelper
  def rails_msg(key)
    key = key.to_sym
    unless [:alert, :notice, :error].include?(key)
      raise ArgumentError, 'Can only handle alert, notice and error messages.'
    end

    return '' if flash[key].blank?

    capture_haml do
      haml_tag("##{key}") do
        haml_concat flash[key]
      end
    end
  end
end
