library("shiny")
library("gridlayout")
library("magick")
library("magrittr")
library("bslib")
library("tesseract")
library("shinybrowser")
library("waiter")
library("sessioninfo")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

main_layout <- c(
    "10px  1fr      1fr      1fr",
    "100px header   header   header",
    "500px sidebar  receiptValues   manualAdjust",
    "800px photoReceipt textReceipt howMuch"
)
mobile_layout <- c(
    "10px  380px",
    "100px header",
    "400px sidebar",
    "600px photoReceipt",
    "300px textReceipt",
    "400px receiptValues",
    "550px manualAdjust",
    "300px howMuch"
)

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/misc/split_receipt/example_text.rds"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/misc/split_receipt/a3080d75-fcb0-4b6c-8132-eb69c2c50199.JPG"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    #sce <- readRDS(posit_connect_file)
    img_default <-
        image_read(posit_connect_file) %>%
        image_deskew() %>%
        image_rotate(12) %>%
        image_resize("2000x") %>%
        image_convert(type = "Grayscale") %>%
        image_contrast() %>%
        image_trim(fuzz = 40)

} else {
    #sce <- readRDS(here::here("misc", "split_receipt", "processed-data", "a3080d75-fcb0-4b6c-8132-eb69c2c50199.JPG"))
    img_default <-
        image_read(here::here("misc", "split_receipt", "processed-data", "a3080d75-fcb0-4b6c-8132-eb69c2c50199.JPG")) %>%
        image_deskew() %>%
        image_rotate(12) %>%
        image_resize("2000x") %>%
        image_convert(type = "Grayscale") %>%
        image_contrast() %>%
        image_trim(fuzz = 40)

}

#if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
#    sce <- readRDS(posit_connect_file1)

#} else {
#    sce <- readRDS(here::here("misc", "split_receipt", "processed-data", "example_text.rds"))

#}



img_default <-
    image_read("a3080d75-fcb0-4b6c-8132-eb69c2c50199.JPG") %>%
    image_deskew() %>%
    image_rotate(12) %>%
    image_resize("2000x") %>%
    image_convert(type = "Grayscale") %>%
    image_contrast() %>%
    image_trim(fuzz = 40)

# text_default <- image_ocr(img_default)
# saveRDS(text_default, file = "example_text.rds")
text_default <- "Follow these steps:
* Upload a receipt
* Rotate the receipt until you can
  read the text horizontally
* Extract the text from the receipt
* Select the correct items, subtotal,
and total.
* Adjust manually if needed.
                        Enjoy! ^_^"

ui <- grid_page(
    theme = bslib::bs_theme(version = 5, bootswatch = "united"),
    layout = new_gridlayout(main_layout, alternate_layouts = list(
        list(layout = mobile_layout, width_bounds = c(max = 600))
    )),
    gap_size = "1rem",
    autoWaiter(),
    grid_card(
        area = "sidebar",
        card_header("Receipt photo 📷"),
        card_body(
            fileInput("yourImage", NULL, accept = c(".png", ".jpg", ".jpeg")),
            helpText("Upload a receipt photo or take one with your phone camera."),
            numericInput(
                inputId = "imgRotation",
                label = "Clockwise image rotation angle",
                value = 12,
                min = 0,
                max = 359,
                step = 1,
                width = "100%"
            ),
            helpText("Change the angle to improve the text automatic scanning."),
            actionButton("update_image", "(1) Update image")
        )
    ),
    grid_card_text(
        area = "header",
        content = "Split your receipt! 🧾",
        alignment = "start",
        is_title = TRUE
    ),
    grid_card(
        area = "howMuch",
        card_header("How much you owe 💸"),
        card_body(
            verbatimTextOutput(outputId = "amountYouOwe"),
            helpText(
                "Copy paste this text into your pay/request message to your friends ^_^."
            )
        )
    ),
    grid_card(
        area = "receiptValues",
        card_header("Figuring out how much you owe 🧮"),
        card_body(
            selectInput(
                inputId = "myItems",
                label = "Items you are paying for",
                choices = c(),
                multiple = TRUE
            ),
            helpText("Select 1 or more items"),
            selectInput(
                inputId = "receiptSubtotal",
                label = "Subtotal (no taxes/tips)",
                choices = c(),
                multiple = FALSE
            ),
            selectInput(
                inputId = "receiptTotal",
                label = "Total (with taxes/tips)",
                choices = c(),
                multiple = FALSE
            )
        )
    ),
    grid_card(
        area = "manualAdjust",
        card_header("Manual adjustments 🔎"),
        card_body(
            numericInput(
                inputId = "adjustItems",
                label = "Adjust your items",
                value = 0
            ),
            helpText(
                "Useful if an item was not recognized correctly."
            ),
            numericInput(
                inputId = "adjustSubtotal",
                label = "Adjust subtotal",
                value = 0
            ),
            helpText(
                "Useful when the subtotal incorrectly includes taxes/tips, as in the example receipt: substract -7.72 to get the accurate subtotal prior to taxes/tips."
            ),
            numericInput(
                inputId = "extraTip",
                label = "Extra tip",
                value = 0
            ),
            helpText(
                "Useful when adding handwritten extra tip: handwriting is not recognized by this app."
            )
        )
    ),
    grid_card(
        area = "textReceipt",
        card_header("Automatically scanned text 📝"),
        card_body(verbatimTextOutput(outputId = "receiptText")),
        helpText(
            "Only numbers with decimals are used later."
        )
    ),
    grid_card(
        area = "photoReceipt",
        card_header("Processed receipt image 🖼️"),
        card_body(
            plotOutput(
                outputId = "processedReceipt",
                height = "800px"
            ),
            actionButton("extract_text", "(2) Extract text from image")
        )
    ),
    bslib::card_footer(
        HTML(
            "
            <hr />
            <p>This <a href='https://shiny.rstudio.com/'>shiny</a> application was developed by <a href='http://lcolladotor.github.io/'>Leonardo Collado Torres</a>. Check the code on <a href='https://github.com/lcolladotor/split_receipt'>GitHub</a>.</p>
        "
        )
    ),
    bslib::card_footer(
        HTML(
            "
        <hr />
        <center>
                <script type='text/javascript' id='clustrmaps' src='//cdn.clustrmaps.com/map_v2.js?cl=ffffff&w=300&t=n&d=D6u6SGD4V9Aj6RtXNpBFkBLHOVT4pH7YDiE7BMAN6q0'></script>
            </center>
        "
        )
    ),
    bslib::card_footer(
        hr(),
        helpText(
            "This website is meant to help you figure out how much you owe when you split a restaurant / bar bill with your colleagues and/or friends. It makes the simplifying assumption that taxes and tips will be split proportionally to what you consumed. For instance, in Maryland (USA) food and alcohol taxes are not the same: it's 6% for food (sales in general) and 9% for alcohol items. If you want to split bills precisely you would need to know what type of tax was applied for every item in a receipt, which is painful. As the difference is typically small, doing the precise math is not needed in general. Thus you can approximate out how much you owe by (1) calculating the proportion of the subtotal that you consumed, (2) multiplying the overall total (after taxes and tips) by that proportion, and (3) rounding it off to two decimals."
        )
    ),
    tags$head(
        tags$link(rel = "icon", href = "https://github.com/lcolladotor/lcolladotorsource/blob/master/assets/media/icon.png?raw=true")
    ),
    shinybrowser::detect()
)


server <- function(input, output, session) {
    # myCamera <- callModule(
    #     shinyviewr, "my_camera",
    #     output_width = 250,
    #     output_height = 250
    # )
    rv <- reactiveValues(img_mod = img_default)

    observeEvent(input$yourImage,
                 {
                     updateNumericInput(
                         session = session,
                         inputId = "imgRotation",
                         value = 0
                     )
                 },
                 priority = 20
    )

    w_update_img <- Waiter$new(id = "processedReceipt")
    observeEvent(input$update_image,
                 {
                     if (is.finite(input$imgRotation)) {
                         w_update_img$show()
                         if (!is.null(input$yourImage)) {
                             img <- image_read(input$yourImage$datapath)
                             if (shinybrowser::get_device() == "Mobile") {
                                 img <- image_rotate(img, 90)
                             }
                         } else {
                             img <- image_read("a3080d75-fcb0-4b6c-8132-eb69c2c50199.JPG")
                         }
                         img_mod <- img %>%
                             image_deskew() %>%
                             image_rotate(input$imgRotation) %>%
                             image_resize("2000x") %>%
                             image_convert(type = "Grayscale") %>%
                             image_contrast() %>%
                             image_trim(fuzz = 40)

                         rv$img_mod <- img_mod
                         w_update_img$hide()
                     }
                 },
                 priority = 10
    )

    output$processedReceipt <- renderImage(
        {
            img_to_view <- rv$img_mod

            if (shinybrowser::get_device() == "Mobile") {
                if (!is.null(input$yourImage)) {
                    ## Deal with weird edge case where the image created by
                    ## image_write() is out of sync with what the data is really
                    ## seeing. Only happens on mobile for some reason.
                    img_to_view <- image_rotate(img_to_view, -90)
                }
            }
            outfile <- tempfile(fileext = ".png")
            image_write(img_to_view, path = outfile)

            # Return a list
            list(
                src = outfile,
                alt = "Rotated and processed image"
            )
        },
        deleteFile = TRUE
    )

    output$receiptText <- renderPrint({
        cat(text_default)
    })

    w_extract_text <- Waiter$new(id = "receiptText")
    observeEvent(input$extract_text, {
        w_extract_text$show()
        text <- rv$img_mod %>%
            image_ocr()
        output$receiptText <- renderPrint({
            cat(text)
        })
        w_extract_text$hide()

        numbers_in_text <-
            as.numeric(gsub(
                "\\,",
                ".",
                stringr::str_extract_all(text, "[0-9]+(\\.|\\,)[0-9]+")[[1]]
            ))
        numbers_in_text <-
            numbers_in_text[is.finite(numbers_in_text)]
        if (length(numbers_in_text) == 0) {
            numbers_in_text <- 0
        }
        updateSelectInput(
            session = session,
            inputId = "myItems",
            choices = numbers_in_text,
            selected = NULL
        )
        updateSelectInput(
            session = session,
            inputId = "receiptSubtotal",
            choices = sort(unique(numbers_in_text), decreasing = TRUE),
            selected = tail(head(
                sort(unique(numbers_in_text), decreasing = TRUE), 2
            ), 1)
        )
        updateSelectInput(
            session = session,
            inputId = "receiptTotal",
            choices = sort(unique(numbers_in_text), decreasing = TRUE),
            selected = max(numbers_in_text)
        )
        output$amountYouOwe <- renderPrint({
            subtotal_yours <-
                sum(as.numeric(input$myItems), na.rm = TRUE) + input$adjustItems
            subtotal_all <-
                sum(as.numeric(input$receiptSubtotal), na.rm = TRUE) +
                input$adjustSubtotal
            total_all <-
                sum(as.numeric(input$receiptTotal), na.rm = TRUE) + input$extraTip

            cat(
                c(
                    " Your total: ",
                    subtotal_yours,
                    "\n",
                    "Subtotal (no taxes/tips): ",
                    subtotal_all,
                    "\n",
                    "Proportion you are paying: ",
                    round(subtotal_yours / subtotal_all, 4),
                    "\n",
                    "Total (with taxes/tips): ",
                    total_all,
                    "\n",
                    "-----------------\n",
                    "You owe: ",
                    round(subtotal_yours / subtotal_all * total_all, 2),
                    "\n"
                )
            )
        })
    })
}

## Reproducibility info
options(width = 120)
print(sessioninfo::session_info())

shinyApp(ui, server)

