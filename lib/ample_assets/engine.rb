require 'ample_assets'
require 'rails'
require 'rack/cache'
require 'dragonfly'

module AmpleAssets
  class Engine < Rails::Engine
    isolate_namespace AmpleAssets
    
    initializer 'configure rack/cache' do |app|
      app.middleware.insert 0, ::Rack::Cache, {
        :verbose     => true,
        :metastore   => "file:#{Rails.root}/tmp/dragonfly/cache/meta",
        :entitystore => "file:#{Rails.root}/tmp/dragonfly/cache/body"
      }
    end
    
    initializer 'configure dragonfly' do |app|
      dfly = Dragonfly[:images]
      dfly.define_macro ActiveRecord::Base, :image_accessor
      dfly.register_mime_type(:swf, 'application/x-shockwave-flash')
      dfly.configure_with(:rails)
      app.middleware.insert_after ::Rack::Cache, ::Dragonfly::Middleware, :images
    end
    
  end
end
