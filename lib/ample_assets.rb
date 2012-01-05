require "ample_assets/engine"

module AmpleAssets
  class << self


    # hooks WillPaginate::ViewHelpers into ActionView::Base
    def enable_actionpack
      return if ActionView::Base.instance_methods.include? :will_paginate
      require 'ample_assets/view_helpers'
      ActionView::Base.send :include, ViewHelpers

      #if defined?(ActionController::Base) and ActionController::Base.respond_to? :rescue_responses
      #  ActionController::Base.rescue_responses['WillPaginate::InvalidPage'] = :not_found
      #end
    end

  end
end

if defined? Rails
  AmpleAssets.enable_actionpack if defined? ActionController
end
