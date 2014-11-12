discourse-openstreetmap
=======================

Discourse plugin to support OSM via URL Oneboxing and iframe whitelisting


## Installation on top of Docker image

Add to your `/var/discourse/containers/app.yml`:

```ruby
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/lidel/discourse-openstreetmap.git
```

Rebuild Discourse: `/var/discourse/launcher rebuild app`

## FAQ

### What URLs are oneboxed?

`http://www.openstreetmap.org/?mlat=[Marker Latitude]&mlon=[Marker Longitude]#map=[Zoom Level]/[Latitude]/[Longitude]&layers=[Layer code]`

### Why URLs without *Marker* parameters are not being oneboxed?

The `map` parameter is located inside URL hash.
Root URLs without query parameters are currently [ignored by onebox library](https://github.com/discourse/onebox/blame/master/lib/onebox/matcher.rb#L17).
This is a temporary inconvenience: upstream fix will be introduced soon.

### I don't like oneboxing: can't I just copy&paste `<iframe>` code from OpenStreetMap.org's share menu?

Sure you can: this plugin whitelists posting iframes from openstreetmap.org.
