module ServicesHelper
  OptionsForRecurrence = Struct.new(:id, :description)

  def options_for_recurrence
    # map mapeia e poupa de ter que mostrar valor da variavel
    Service.recurrences.map do |key, value|
      if value == 0
        value = 'Mensal'
      elsif value  == 1
        value = 'Trimestral'    
      elsif value  == 2
        value = 'Semestral'
      elsif value  == 3
        value = 'Anual'
      elsif value  == 4
        value = 'A vista'
      else
        value = 'Parcelado'
      end
      OptionsForRecurrence.new(key, value)
    end
  end
end
