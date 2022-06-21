class Municipe < ApplicationRecord
  include Basic
    
  belongs_to :address

	validates :birth_date, :cns, :email, :cpf, :full_name, :telephone, presence: true
  validate :cpf_valid?
  validate :is_email_valid?
  # validate :cns_valid?

  validates_associated :address
  accepts_nested_attributes_for :address

  mount_uploader :municipe, MunicipeUploader

  def cpf_valid?
    invalid_cpf_values = CPF_INVALID_DIGITS
    cpf_digit = self.cpf.scan /[0-9]/

    if cpf_digit.length == 11
      unless invalid_cpf_values.member?(cpf_digit.join)
        cpf_digit = cpf_digit.collect{|x| x.to_i}

        cpf_sum = 10*cpf_digit[0]+9*cpf_digit[1]+8*cpf_digit[2]+7*cpf_digit[3]+6*cpf_digit[4]+5*cpf_digit[5]+4*cpf_digit[6]+3*cpf_digit[7]+2*cpf_digit[8]
        cpf_sum = cpf_sum - (11 * (cpf_sum/11))
        cpf_sum_result = (cpf_sum == 0 or cpf_sum == 1) ? 0 : 11 - cpf_sum

        if cpf_sum_result == cpf_digit[9]
          cpf_sum = cpf_digit[0]*11+cpf_digit[1]*10+cpf_digit[2]*9+cpf_digit[3]*8+cpf_digit[4]*7+cpf_digit[5]*6+cpf_digit[6]*5+cpf_digit[7]*4+cpf_digit[8]*3+cpf_digit[9]*2
          cpf_sum = cpf_sum - (11 * (cpf_sum/11))
          cpf_sum_result_last_digit = (cpf_sum == 0 or cpf_sum == 1) ? 0 : 11 - cpf_sum

          self.cpf.gsub!(/[^\d]/, '')

          return true if cpf_sum_result_last_digit == cpf_digit[10]

        end
      end
    end

    return message_error_cpf
  end

  def cns_valid?

    cns = self.cns.gsub!(/\s+/, '')

    return cns_incomplete if cns.length != 15 && !cns.blank?
    return message_error_cns unless cns.match?(/\A\d+\Z/)

    case cns.chars.first
      when '1', '2'
        cns_validation_return = valid_cns(cns)
      when '7', '8', '9'
        cns_validation_return = validate_provisional_cns(cns) 
      else
        return message_error_cns
    end

    return message_error_cns if cns_validation_return == false
  end

  def is_email_valid?
    self.email =~ FORMAT_CHARACTER_EMAIL
  end

  private

  CPF_INVALID_DIGITS = %w{
    12345678909 
    11111111111 
    22222222222 
    33333333333 
    44444444444 
    55555555555 
    66666666666 
    77777777777 
    88888888888 
    99999999999 
    00000000000 
    12345678909
  }

  FORMAT_CHARACTER_EMAIL = /^(.+)@(.+)$/


  def valid_cns(cns)
    pis = cns[0..11]
    
    sum = pis.chars.each_with_index.inject(0) do |result, (char, i)|
      result += char.to_i * (15 - i)
      result
    end

    dv = 11 - (sum % 11)
    dv = dv == 11 ? 0 : dv
    cns_generated = 
      if dv == 10
        sum += 2
        dv = 11 - (sum % 11)
        "#{pis}001#{dv}"
      else
        "#{pis}00#{dv}"
      end
    puts "total da soma #{dv}"
    return cns == cns_generated
  end

  def validate_provisional_cns(cns)
    sum =
      cns.chars.each_with_index.inject(0) do |result, (char, i)|
        result += char.to_i * (15 - i)
        result
      end

    return (sum % 11) == 0
  end

  def message_error_cns
    errors.add(:cns, message: I18n.t("cns_is_not_invalid"))
  end

  def cns_incomplete
    errors.add(:cns, message: I18n.t("cns_incomplete"))
  end

  def message_error_cpf
    errors.add(:cpf, message: I18n.t("cpf_is_not_invalid")) 
  end
end
