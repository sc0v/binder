#$ ->
#  $( "#selectable" ).selectable(
#    stop: ->
#      result = $( "#select-result" ).empty()
#      $( ".ui-selected", this ).each( ->
#          index = $( "#selectable li" ).index( this )
#          result.append( " #" + ( index + 1 ) )
#          alert "hi"
#      )    
#  )
