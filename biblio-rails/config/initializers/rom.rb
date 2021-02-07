Rails.application.config.after_initialize do
  Biblio::Db::Container.init
end
