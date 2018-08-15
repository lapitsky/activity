module ActivityLogging
  extend ActiveSupport::Concern

  included do
    has_many :activity_logs, as: :loggable

    after_create :log_creation
    after_update :log_update
  end

  private

  def log_creation
    activity_logs.create(changes_text: create_description)
  end

  def create_description
    "Created with the following attributes: #{attributes.to_json}"
  end

  def log_update
    activity_logs.create(changes_text: update_description)
  end

  def update_description
    field_changes = saved_changes
      .except(:updated_at)
      .map { |f, ch| "#{f} from #{ch.first.inspect} to #{ch.second.inspect}" }
      .to_sentence

    'Updated ' + field_changes
  end
end
