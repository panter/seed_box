module OmniSeeds
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/omni_seeds.rake'
    end
  end
end
