module ContentPacksHelper
  def error_notification(content_pack, action)
    type = content_pack.published? ? 'published' : 'not_empty'
    I18n.t "content_packs.controller.#{action}.failed.#{type}", name: content_pack.name
  end
end