#' library(tidyverse)
#' library(htmltools)
#' library(htmlwidgets)
#' library(echarts4r)
#' 
#' df <- data.frame(x=c("Mar","Apr","May","Jun","Jul","Aug",
#'                      "Sep","Oct","Nov","Dec","Jan","Feb"),
#'                  y=(1:12)*5)
#' 
#' base_plot <- df %>% 
#'   e_charts(x,
#'            height=200,
#'            width=300) %>% 
#'   e_x_axis(axisLabel=list(rotate=60))
#' 
#' plot1 <- e_line(e=base_plot,
#'                 y) 
#' plot2 <- e_bar(e=base_plot,
#'                y) 
#' plot3 <- e_scatter(e=base_plot,
#'                    y)
#' plot4 <- e_line(e=base_plot,
#'                 y) 
#' plot5 <- e_bar(e=base_plot,
#'                y) 
#' plot6 <- e_scatter(e=base_plot,
#'                    y)
#' plot7 <- e_line(e=base_plot,
#'                 y) 
#' plot8 <- e_bar(e=base_plot,
#'                y) 
#' plot9 <- e_scatter(e=base_plot,
#'                    y)
#' plot10 <- e_line(e=base_plot,
#'                 y) 
#' plot11 <- e_bar(e=base_plot,
#'                y) 
#' plot12 <- e_scatter(e=base_plot,
#'                    y)
#' plot_list <- list(plot1,plot2,plot3,plot4,plot5,plot6,
#'                   plot7,plot8,plot9,plot10,plot11,plot12)
#' 
#' # Plot prep ---------------------------------------------------------------
#' 
#' length_input <- length(plot_list)
#' num_col <- 3
#' num_row <- floor(length_input/num_col) + (length_input%%num_col)
#' row_seq <- seq(1, by = num_col, length.out = num_row)
#' 
#' randID <- paste0("arrange",
#'                  sample.int(100000,1))
#' 
#' # Make SVG
#' 
#' for (i in 1:length_input) {
#'   plot_list[[i]]$x$renderer <- "svg"
#' }
#' 
#' # Fork for pdf/html
#' 
#' if (type=="pdf") {
#'   
#'   # control width 
#'   
#'   for (i in 1:length_input) {
#'     plot_list[[i]]$width <- 325
#'   }
#'   
#'   
#' } else if (type=="html") {
#'   
#'   # connect groups
#'   
#'   for (i in 1:length(plot_list)) {
#'     if (i==length(plot_list)) {
#'       plot_list[[i]] <- plot_list[[i]] %>% 
#'         e_group(randID) %>% 
#'         e_connect_group(randID)
#'     } else {
#'       plot_list[[i]] <- plot_list[[i]] %>% 
#'         e_group(randID)
#'     }
#'   }
#'   
#' }
#' 
#' container_list <- list()
#' for (i in 1:num_row) { 
#'   low_row <- row_seq[i]
#'   high_row <- row_seq[i]+2
#'   row <-lapply(plot_list[low_row:high_row], function(plot) {
#'     tags$div(
#'       class = "box",
#'       plot
#'     )
#'   })
#'   container_list[[i]] <- tags$div(
#'     class="container",
#'     row,
#'     tags$br()
#'   )
#' }
#' 
#' 
#' html_out <- tags$div(tags$style("
#'                                 @page {
#'     size: 297mm 216mm; /* Set the page size to 297mm x 216mm */
#'     margin: 0; /* Remove default margin */
#'   }
#' 
#'   body {
#'     margin: 0; /* Remove default body margin */
#'     padding: 20mm; /* Add padding to mimic content area */
#'   }
#'                                 .container {
#'     display: flex; /* Use Flexbox layout */
#'   }
#'   
#'   .box {
#'     width: 33%; /* Each box takes up X% of the container's width */
#'     border: 1px solid #000; /* Just for visualization */
#'     box-sizing: border-box; /* Include borders in width calculation */
#'   justify-content: center;  
#'   }
#'   
#'   .page-break {
#'     page-break-before: always; /* or page-break-after: always; CHATGPT */
#'   }
#'   
#'   "),
#'   plot9,
#'   container_list)
#' 
#' html_print(html_out)



