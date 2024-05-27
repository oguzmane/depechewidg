#' Dropdown button creator
#'
#' Create a dropdown button for a list of visuals 
#' @param visualList the list of all visuals 
#' @param metricVec a vector of character names for each visual in the dropdown
#' @param num_breaks an integer to determine number of breaks (tags$br()) to insert between dropdown button and visuals
#' @param fontSize an integer to specify font size (in pixels) of dropdown button labels
#' @return a visual with a dropdown button
#' @examples 
#' vis_drop <- dropFUN(list(table1,plot1),c("Table","Plot"))
#' @export
dropFUN <- function(visualList,metricVec,num_breaks=NULL,
                    fontSize=14) {
  
  if (length(visualList)!=length(metricVec)) {
    
    stop("Visual list is not the same length as input labels!")
    
  }
  
  randRange <- 99999999
  
  main <-data.frame(value=sample.int(randRange,length(metricVec)),
                    name=metricVec)
  
  optionTag <- list()
  
  for (i in 1:length(main$name)) {
    
    optionTag[[i]] <- htmltools::tags$option(main$name[[i]],
                                             class="metric-option",
                                             value=paste0(main$value[[i]]))
    
  }
  
  divTag <- list()
  
  for (i in 1:length(main$name)) {
    
    if (i==1) {
      
      divTag[[i]] <- htmltools::tags$div(visualList[[i]],
                                         id=paste0("drop",main$value[[i]]),
                                         class=paste0("inv",main$value[[1]]),
                                         style="display:block;")
      
    } else {
      
      divTag[[i]] <- htmltools::tags$div(visualList[[i]],
                                         id=paste0("drop",main$value[[i]]),
                                         class=paste0("inv",main$value[[1]]," inv2",
                                                      main$value[[1]]))
      
      
    }
    
  }
  
  if (is.null(num_breaks)) {
    breaks_to_add <- NULL
  } else {
    breaks_to_add <- replicate(num_breaks, tags$br(), simplify = FALSE)
  }
  
  htmltools::tags$html(
    htmltools::tags$style(".metric-drop {
  color: rgb(89, 89, 89);
  padding: 16px;
  font-size: ",paste0(fontSize,"px"),";
  border-color: rgb(89, 89, 89);
  border-radius: 36px;
  font-family:'Verdana';
  font-weight:bold;
  text-align:center;
}
.metric-option {
color: rgb(89, 89, 89);
}"),
    htmltools::tags$script(src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"),
    htmltools::tags$script("$(document).ready(function(){
                let selectRand = Math.random( );
                var inVal = document.querySelector('#select_id')[0];
                $('#select_id').attr('id',selectRand).on('change', function(){
                var demovalue = $(this).val();
                $('div.inv'+inVal.value).hide();
                $('#drop'+demovalue).fadeIn();
                window.dispatchEvent(new Event('resize')); //FIX 1.1
              });
              $( window ).load(function () {
                  $('div.inv2'+inVal.value).hide();
                });
            });"),
    htmltools::tags$select(id="select_id",
                           class="metric-drop",
                           optionTag),
    breaks_to_add,
    divTag)
  
  
}



