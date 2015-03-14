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

### What URLs are oneboxed by this plugin?

`http://www.openstreetmap.org/?mlat=[Marker Latitude]&mlon=[Marker Longitude]#map=[Zoom Level]/[Latitude]/[Longitude]&layers=[Layer code]`

### I don't like/need oneboxing: can't I just copy&paste `<iframe>` code from OpenStreetMap.org's share menu?

Sure you can! You don't even need this plugin for that, as [iframe code is whitelisted in Discourse itself since v1.1.1](https://github.com/discourse/discourse/commit/9dccd975d9446fc99f4c76322b8934c5afd25888).

