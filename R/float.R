#' Two-column creator
#'
#' Create a two-column layout for lists of different visuals 
#' @param leftList the list for all visuals on the left column
#' @param rightList the list for all visuals on the right column
#' @param width a two-numbered vector for the relative width of left and right, in %
#' @return a two-column layout
#' @examples 
#' two_column_vis <- floatFUN(table1,plot1,c(40,60))
#' @export
floatFUN <- function(leftList,rightList,width) {
  
  leftTag <-  htmltools::tags$div(leftList,
                                  style=paste0("float:left;width:",
                                               width[[1]],
                                               "%;"))
  
  rightTag <- htmltools::tags$div(rightList,
                                  style=paste0("float:right;width:",
                                               width[[2]],
                                               "%;"))
  
  combineList <- list(leftTag,rightTag)
  
  
  htmltools::tags$div(combineList,style="overflow:hidden;") 
  
  
}