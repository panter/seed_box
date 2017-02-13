namespace :db do
  # Define a helper to have the methods included in the seeds files directly
  task seed: :seed_helper

  # namespace :seed do
    # desc 'Load the seed data from db/seeds/production.rb'
    # task production: [:environment, :seed_helper] do
    #   load Rails.root.join('db/seeds/production.rb')
    # end
  # end

  task :seed_helper do
    require 'omni_seeds'
    include OmniSeeds
  end
end
