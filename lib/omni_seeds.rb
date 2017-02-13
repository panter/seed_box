require 'rails'
require 'active_record'

require 'omni_seeds/version'
require 'omni_seeds/railtie'

module OmniSeeds
  def seed(model, find_or_create_by, update_with = {})
    record = model.where(find_or_create_by).first_or_initialize

    record.update_attributes(update_with)

    handle_errors(record, find_or_create_by, update_with)
  end

  def seed_once(model, find_or_create_by, update_with = {})
    record = model.where(find_or_create_by).first_or_initialize(update_with)

    record.save

    handle_errors(record, find_or_create_by, update_with)
  end

  def seed_file(name)
    File.new(Rails.root.join('db/seeds').join(name))
  end

  private

  def handle_errors(record, find_or_create_by, update_with)
    return true if record.valid?

    raise "Couldn't save #{record.class} " +
      "(#{record.errors.full_messages.join(', ')}) with provided data: " +
      "#{find_or_create_by.inspect}, #{update_with.inspect}"
  end
end
