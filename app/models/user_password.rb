class UserPassword < ApplicationRecord
  # Owner can do everythin
  # Editor can update password
  # Viewer can view
  ROLES = %w{owner editor viewer}
  # The %w{} syntax is used for creating an array of strings

  belongs_to :user
  belongs_to :password

  validates :role, presence: true, inclusion: { in: ROLES }

  def owner?
    role == "owner"
  end
  def editor?
    role == "editor"
  end
  def viewer?
    role == "viewer"
  end

  def editable?
    owner? || editor?
  end

  def shareable?
    owner?
  end
 
  def deletable?
    owner?
  end
end
