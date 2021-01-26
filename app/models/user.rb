class User < ApplicationRecord
  PASSWORD_REQUIREMENTS =/\A
  (?=.{6,})
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
  /x
  has_secure_password
  has_many :suggestions
  has_many :votes
  has_many :comments
  has_many :likes, through: :comments
  validates :username, :email, uniqueness: true
  validates :password, format: { with: PASSWORD_REQUIREMENTS, message: "must be minimum of 6 characters. 
  Contain an  uppercase letter. 
  Contain a number." }, on: [:change_password, :create]
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+[a-zA-Z0-9]+\z/ }  
  validates :username, format: {with: /\A[a-zA-Z0-9]+\z/ } 

  def change_password(password)
    with_transaction_returning_status do
      assign_attributes(password: password)
      save(context: :change_password)
    end
  end
end
