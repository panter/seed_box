namespace :db do
  # * define a helper to have the methods included in the seeds files directly
  # * additionally to the normal rails seeds, the production seeds are also
  #   included
  desc 'Load the seed data from db/seeds.production.rb'
  task seed: [:seed_helper, :'seed:production']

  namespace :seed do
    desc 'Load the seed data from db/seeds.production.rb'
    task production: [:environment, :seed_helper] do
      file = Rails.root.join('db/seeds.production.rb')
      load file if File.exist?(file)
    end
  end

  task :seed_helper do
    require 'seed_box'
    include SeedBox
  end
end
