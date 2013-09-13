require 'bcrypt'
class Member < ActiveRecord::Base
  ACCESSIBLE_ATTRS = [:name, :full_name, :email, :birthday, :gender,:password, :password_confirmation]
  attr_accessible *ACCESSIBLE_ATTRS
  attr_accessible *(ACCESSIBLE_ATTRS + [:number, :administrator])
  attr_accessor :password, :password_confirmation

  validates :number, presence: true,
  	numericality: { only_integer: true,
  		greater_than: 0, less_than: 100, allow_blank: true },
  		uniqueness: true
  		
  validates :name, presence: true,
  	format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true, message: :invalid_member_name},
  	length: { minimum: 2, maximum: 20, allow_blank: true},
  	uniqueness: {case_sensitive: false}
  	
  validates :full_name, length: {maximum: 20}

  validates :password, presence: { on: :create},
    confirmation: {allow_blank: true}
  
  #validate :check_email

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end
  
  class << self
  	def search(query)
  		rel=order("number")
  		if query.present?
  			rel=rel.where("name LIKE ? OR full_name LIKE ?", "%#{query}%", "%#{query}%")
  		end
  		rel
  	end

    def authenticate(name, password)
      member=find_by_name(name)
      if member && member.hashed_password.present? && BCrypt::Password.new(member.hashed_password) == password
        member
      else
        nil
      end
    end
  end
  
end
