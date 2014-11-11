# name: OpenStreetMap Onebox
# version: 0.1
# authors: Marcin Rataj

# whitelist raw iframes
register_asset('javascripts/iframe_whitelist.js', :server_side)

class Onebox::Engine::OpenStreetMapOnebox
  include Onebox::Engine

  # oneboxing canonical links into iframes
  matches_regexp(/^https?:\/\/(?:www\.)?(?:openstreetmap\.org\/\?mlat)\/.+$/)

  def to_html
    "<iframe src='#{@url}' style='border: 0' width='100%' height='350' frameborder='0' scrolling='no'></iframe>"
  end
end
