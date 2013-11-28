import Widget from require "lapis.html"
class Albums extends Widget
    content: =>
      div class:"items", ->
        for index, album in pairs @albums 
         -- Skip albums with no images in them
         unless album.image
           continue
         div class:"item", ->
            a href:@url_for("album", token:album.token, title:album.title), -> 
              img src:@url_for("img", token:album.image.token, filename:album.image.thumb_name)
            div class:"album-label", ->
              a href:@url_for("album", token:album.token, title:album.title), ->
                i class:"fa fa-camera-retro"
                text " "..album.title
      div id:"spinner", class:"spinner", ->
        text "Loading ..."
      raw [[
      <script>
      $(document).on("ready", function (evt) {
          pnx = photongx($('.items'), $('.item'));
      });
      </script>
      ]]
