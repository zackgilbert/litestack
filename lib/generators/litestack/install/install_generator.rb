class Litestack::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def modify_database_adapater
    gsub_file "config/database.yml", "adapter: sqlite3", "adapter: litedb"
  end

  def modify_cache_store_adapter
    gsub_file "config/environments/production.rb",
      "# config.cache_store = :mem_cache_store",
      "config.cache_store = :litecache, { path: './db/cache.db' }"
  end

  def modify_active_job_adapter
    gsub_file "config/environments/production.rb",
      "# config.active_job.queue_adapter     = :resque",
      "config.active_job.queue_adapter = :litejob"
  end

  def modify_action_cable_adapter
    # I force copy this so defaults Rails installs don't ask questions
    # that less experienced people might not understand. The more Sr folks.
    # will know to check git to look at what changed.
    copy_file "cable.yml", "config/cable.yml", force: true
  end
end
