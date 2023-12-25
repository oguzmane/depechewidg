
# ICD CONVERT -------------------------------------------------------------

icd_convFUN <- function(df) {
  
  df %>% 
    mutate(start_code=substr(cause,1,1),
           end_code=substr(cause,2,4),
           end_code=case_when(nchar(end_code)==2 ~ paste0(end_code,"0"),
                              T ~ end_code),
           end_code=as.numeric(end_code),
           label=case_when(start_code=="C"&between(end_code,330,349) ~ "lung",
                           start_code=="C"&between(end_code,180,209) ~ "bowel",
                           grepl("C61",cause) ~ "prostate",
                           grepl("C50",cause) ~ "breast",
                           grepl("C25",cause) ~ "pancreas",
                           grepl("C15",cause) ~ "oesoph",
                           grepl("C22",cause) ~ "liver",
                           grepl("C67",cause) ~ "bladder",
                           start_code=="C"&between(end_code,700,729)|
                             start_code=="C"&between(end_code,751,753)|
                             start_code=="D"&between(end_code,320,339)|
                             start_code=="D"&between(end_code,352,354)|
                             start_code=="D"&between(end_code,420,439)|
                             start_code=="D"&between(end_code,443,445)~"brain",
                           start_code=="C"&between(end_code,820,869)~"lymph",
                           start_code=="C"&between(end_code,910,959)~"leuk",
                           start_code=="C"&between(end_code,640,669)|
                             grepl("C68",cause)~"kidney",
                           grepl("C16",cause)~"stomach",
                           start_code=="C"&between(end_code,0,149)|
                             start_code=="C"&between(end_code,300,329)~"head",
                           start_code=="C"&between(end_code,560,574)~"ovary",
                           grepl("C90",cause)~"myeloma",
                           start_code=="C"&between(end_code,540,559)~"uterus",
                           ### NOTE MESO COMMENTED OUT HERE, PLACED IN OTHER ####
                           # grepl("C45",cause)~"meso",
                           ######################################################                           grepl("C43",cause)~"melanoma",
                           start_code=="C"&between(end_code,770,809)~"secondary",
                           T ~ "other")) 
  
}





# DROPDOWN BUTTON ---------------------------------------------------------

#' Dropdown button creator
#'
#' Create a dropdown button for a list of visuals 
#' @param visualList the list of all visuals 
#' @param metricVec a vector of character names for each visual in the dropdown
#' @return a visual with a dropdown button
#' @examples 
#' vis_button <- buttonFUN(list(table1,plot1),c("Table","Plot"))
#' @export
buttonFUN <- function(visualList,metricVec) {
  
  if (length(visualList)!=length(metricVec)) {
    
    stop("Visual list is not the same length as input labels!")
    
  }
  
  randRange <- 99999999
  
  main <-data.frame(value=sample.int(randRange,size=length(metricVec)),
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
  
  htmltools::tags$html(
    htmltools::tags$style(".metric-drop {
  color: rgb(89, 89, 89);
  padding: 16px;
  font-size: 14px;
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
              });
              $( window ).load(function () {
                  $('div.inv2'+inVal.value).hide();
                });
            });"),
    htmltools::tags$select(id="select_id",
                           class="metric-drop",
                           optionTag),
    htmltools::tags$br(),
    htmltools::tags$br(),
    divTag)
  
  
}



# 2-COLUMN ----------------------------------------------------------------

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



# TAB ---------------------------------------------------------------------


tabFUN <- function(visualList,tabVec) {
  
  if (length(visualList)!=length(tabVec)) {
    
    stop("Visual list is not the same length as tab labels!")
    
  }
  
  rand <- sample.int(99999999,1)
  
  aTag <- list()
  
  for (i in 1:length(tabVec)) {
    
    aTag[[i]] <- htmltools::a(tabVec[i],
                              href="#",
                              id=paste0("tab",rand,i))
    
  }
  
  divTag <- list()
  
  for (i in 1:length(tabVec)) {
    
    if (i==1) {
      
      divTag[[1]] <- htmltools::tags$div(visualList[[1]],
                                         id=paste0("tab",rand,1))
      
    } else {
      
      divTag[[i]] <- htmltools::tags$div(visualList[[i]],
                                         id=paste0("tab",rand,i),
                                         class=paste0("hidenav",rand))
      
    }
    
  }
  
  arr <- paste(seq(1,length(tabVec)),collapse=", ")
  
  htmltools::tags$html(
    htmltools::tags$style(
      ".top {
  background:#99b5c7;
  overflow:hidden;
  font-family:'Varela Round';
  color: #f2f2f2;
  }
  .top a {
  float: left;
  display: block;
  color: black;
  text-align: center;
  margin-right: 50px;
  margin-left: 15px;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  }
  .top a:hover {
  background-color: #ddd;
  color: black;
  }
  a:checked {
  background-color: #ddd;
  color: black;
  }"),
  htmltools::br(),
  htmltools::br(),
  htmltools::tags$script(src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"),
  # htmltools::tags$script(paste0("const rand = ",rand)),
  # htmltools::tags$script(paste0("const arr = [",arr,"]")),
  htmltools::tags$script(paste0(
    "$(document).ready(function(){
    
    const rand =",rand," 
    const arr = [",arr,"]
    $.each( arr, function( index, value ){
  
      $('a#tab'+rand+value).on('click',function() {
        
        function canFil(ind) {
          return ind != arr[index]
        };
  
        let newarr = arr.filter(canFil);
  
        $.each( newarr, function( index2, value2 ){
          $('div#tab'+rand+value2).hide(); 
        });
  
        $('div#tab'+rand+value).fadeIn();
          return false;
        });
  
    });
      
    $( window ).load(function () {
      $('div.hidenav'+rand).hide();
    }); 
  
  });
"
  )),
htmltools::div(id=paste0("navbar",rand),
               class="top",
               aTag,
),
htmltools::br(),
htmltools::br(),
divTag)
  
  
}



























