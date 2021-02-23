class User < ActiveRecord::Base
  include Spotlight::User
  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ###
  # Normally, this would be provided by device_invitable via
  # `devise :invitable`. However, since we're not doing that
  # yet, this will have to do.
  def invited_to_sign_up?
    false
  end
end
