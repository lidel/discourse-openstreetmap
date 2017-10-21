discourse-openstreetmap
=======================

> Discourse plugin to support OSM via URL Oneboxing

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

    https://www.openstreetmap.org/?mlat=[Marker Latitude]&mlon=[Marker Longitude]#map=[Zoom Level]/[Latitude]/[Longitude]&layers=[Layer code]

will be onboxed as a mini-map:

> ![onebox-sample](https://user-images.githubusercontent.com/157609/31852642-79ace722-b67b-11e7-848f-41ba85fd80ef.png)

### Can I just copy&paste `<iframe>` code from OpenStreetMap.org's share menu?

Sure you can! In past it was done by this plugin, but there is now an `allowed iframes` setting on the Discourse settings page itself at `/admin/site_settings/category/all_results?filter=allowed_iframes`.

Something to keep in mind: embedding of OSM `iframe` is enabled by default only for HTTPS URL. This means if it does not work for you, change `<iframe src=http://www.openstreetmap.org/export/embed.html?(..)` to have `src=https://` instead.


> ![iframe-example](https://user-images.githubusercontent.com/157609/31852829-4c23c4f2-b67f-11e7-8cd3-f0d4c14bf93c.png)

### Is this all there is? I want more OSM integration!

You are in luck! There is a great [Locations Plugin](https://meta.discourse.org/t/locations-plugin/69742?u=lidel), which can be installed in addition to this one.
