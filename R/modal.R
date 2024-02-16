#' Modal creator
#'
#' Create a modal (shown via action button) for a list of visuals 
#' @param visualList the list of all visuals to put in modal
#' @param buttonLabel label to give button that activates modal
#' @return an action button that, when pressed, presents a modal
#' @examples 
#' modal_button <- modalFUN(list(plot1),"Click for modal")
#' @export
modalFUN <- function(visualList,buttonLabel) {
  
  rand <- sample.int(99999999,1)
  
  btn_id <- paste0("Btn-",rand)
  modal_id <- paste0("Modal-",rand)
  
  htmltools::tags$html(
    htmltools::tags$button(id=btn_id,buttonLabel),
    htmltools::tags$div(id=modal_id,class="modal",
                        htmltools::tags$div(class="modal-content",
                                            visualList)
    ),
    htmltools::tags$script(src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"),
    htmltools::tags$script(paste0('$(document).ready(function(){
  
  const modal = document.getElementById("',modal_id,'");
  const btn = document.getElementById("',btn_id,'");
  
  // When the user clicks the button, open the modal 
  btn.onclick = function() {
    modal.style.display = "block";
    window.dispatchEvent(new Event("resize")); 
  }
  
  // When the user clicks anywhere outside of the modal, close it
  window.addEventListener("click", function(event) { // Fix 1.2
    if (event.target == modal) {
      modal.style.display = "none";
    }
  });
                             
  });
  ')),
  htmltools::tags$style('/* The Modal (background) */
  .modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1000; /* Sit on top */ 
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  }
  
  /* Modal Content */
  .modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
  }
  '))
  
  
}

