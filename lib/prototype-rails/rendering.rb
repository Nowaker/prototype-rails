require 'action_view/helpers/rendering_helper'

ActionView::Helpers::RenderingHelper.module_eval do
  if Rails::VERSION::MAJOR >= 5 && Rails::VERSION::MINOR >= 0
    module RenderWithUpdate
      def render(options = {}, locals = {}, &block)
        if options == :update
          update_page(&block)
        else
          super(options, locals, &block)
        end
      end
    end

    prepend RenderWithUpdate
  else
    def render_with_update(options = {}, locals = {}, &block)
      if options == :update
        update_page(&block)
      else
        render_without_update(options, locals, &block)
      end
    end

    alias_method_chain :render, :update
  end
end