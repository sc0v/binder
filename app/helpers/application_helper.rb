# frozen_string_literal: true

module ApplicationHelper
  # Images
  #
  # Fallback image shown when a record-keyed asset (e.g. store/tool images
  # named after the record) is missing.
  PLACEHOLDER_IMAGE = 'placeholder.png'

  # Render an image_tag that falls back to PLACEHOLDER_IMAGE when the asset is
  # missing, instead of raising Propshaft::MissingAssetError and 500-ing the
  # whole page. Falls back to nothing if even the placeholder is absent.
  def safe_image_tag(source, options = {})
    image_tag(source, options)
  rescue Propshaft::MissingAssetError
    begin
      image_tag(PLACEHOLDER_IMAGE, options)
    rescue Propshaft::MissingAssetError
      nil
    end
  end

  # asset_path that falls back to the placeholder (then nil) instead of raising,
  # so it is safe to build data attributes (e.g. image_url) for the same source.
  def safe_asset_path(source)
    asset_path(source)
  rescue Propshaft::MissingAssetError
    begin
      asset_path(PLACEHOLDER_IMAGE)
    rescue Propshaft::MissingAssetError
      nil
    end
  end

  # Flash
  #
  # Map flash categories to css classes.
  def flash_css_class(name)
    "flash-#{name} " +
      case name
      when 'notice'
        'green invert'
      when 'alert'
        'red invert'
      else
        'gold'
      end
  end
end
