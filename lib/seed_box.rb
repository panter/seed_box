require 'rails'
require 'active_record'

require 'seed_box/version'
require 'seed_box/railtie'

module SeedBox
  def seed(model, find_or_create_by, update_with = {})
    record = model.where(find_or_create_by).first_or_initialize

    record.update(update_with)

    handle_errors(record, find_or_create_by, update_with)
  end

  def seed_once(model, find_or_create_by, create_with = {})
    return if model.where(find_or_create_by).exists?

    seed(model, find_or_create_by, create_with)
  end

  def seed_file(name)
    File.new(Rails.root.join('db/seeds').join(name))
  end

  private

  def handle_errors(record, find_or_create_by, update_with)
    return record if record.valid?

    raise "Couldn't save #{record.class} " +
      "(#{record.errors.full_messages.join(', ')}) with provided data: " +
      "#{find_or_create_by.inspect}, #{update_with.inspect}"
  end
end
