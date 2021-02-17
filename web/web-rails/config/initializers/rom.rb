Rails.application.config.after_initialize do
  Database::Container.init
end
