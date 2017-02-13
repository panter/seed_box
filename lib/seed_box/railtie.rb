module SeedBox
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/seed_box.rake'
    end
  end
end
