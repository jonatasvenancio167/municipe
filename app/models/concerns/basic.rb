module Basic
  extend ActiveSupport::Concern

  included do
    scope :live,   -> { where(deleted_at: nil) }
  end
end
