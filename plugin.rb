# name: OpenStreetMap Onebox
# version: 0.2
# authors: Marcin Rataj

class Onebox::Engine::OpenStreetMapOnebox
  include Onebox::Engine

  # current embed defaults from openstreetmap.org
  @@width     = 425
  @@height    = 350
  @@tile_size = 256
  @@REGEX     = /^https?:\/\/(?:www\.)openstreetmap\.org\/.*#map=([\d\.]+)\/([-\d\.]+)\/([-\d\.]+)/

  # enable oneboxing permalinks (http://wiki.openstreetmap.org/wiki/Permalink) into iframes
  matches_regexp(@@REGEX)

  def to_html
    zoom, lat, lon = @url.match(@@REGEX).captures
    iframe_url = "//www.openstreetmap.org/export/embed.html?bbox=#{get_bbox(lat.to_f, lon.to_f, zoom.to_i)}"

    if marker = @url.match(/mlat=([-\d\.]+).+mlon=([-\d\.]+)/)
      mlat, mlon = marker.captures
      iframe_url = "#{iframe_url}&amp;marker=#{mlat}%2C#{mlon}"
    end

    if layers = @url.match(/layers=(\w+)/)
      iframe_url = "#{iframe_url}&amp;layers=#{layers.captures[0]}"
    end

    "<iframe src='#{iframe_url}' style='border: 0' width='#{@@width}' height='#{@@height}' frameborder='0' scrolling='no'></iframe>"
  end

  private

  # http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames#Lon..2Flat._to_tile_numbers_3
  # note: it is slightly modified as fractional part is not discarded (http://goo.gl/oNtQ5g)
  def get_tile_number(lat_deg, lng_deg, zoom)
    lat_rad = lat_deg/180 * Math::PI
    n = 2.0 ** zoom
    x = (lng_deg + 180.0) / 360.0 * n
    y = (1.0 - Math::log(Math::tan(lat_rad) + (1 / Math::cos(lat_rad))) / Math::PI) / 2.0 * n
    if !y.infinite?.nil?
      y = x
    end

    [x, y]
  end

  # http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames#Tile_numbers_to_lon..2Flat._3
  def get_lat_lng_for_number(xtile, ytile, zoom)
    n = 2.0 ** zoom
    lon_deg = xtile / n * 360.0 - 180.0
    lat_rad = Math::atan(Math::sinh(Math::PI * (1 - 2 * ytile / n)))
    lat_deg = 180.0 * (lat_rad / Math::PI)

    [lat_deg, lon_deg]
  end

  # http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames#Lon..2Flat._to_bbox
  def get_bbox(lat, lon, zoom)

    xtile, ytile = get_tile_number(lat, lon, zoom)

    xtile_s = (xtile * @@tile_size - @@width/2.0)  / @@tile_size
    ytile_s = (ytile * @@tile_size - @@height/2.0) / @@tile_size
    xtile_e = (xtile * @@tile_size + @@width/2.0)  / @@tile_size
    ytile_e = (ytile * @@tile_size + @@height/2.0) / @@tile_size

    lat_s, lon_s = get_lat_lng_for_number(xtile_s, ytile_s, zoom)
    lat_e, lon_e = get_lat_lng_for_number(xtile_e, ytile_e, zoom)

    "#{lon_s}%2C#{lat_s}%2C#{lon_e}%2C#{lat_e}"
  end

end

# vim:ts=2:sw=2:et:
