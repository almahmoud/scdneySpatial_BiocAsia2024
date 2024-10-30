


plotKontextual = function(test, imageChoose) {
  
  test_split = str_split(test, "__")[[1]]
  to = test_split[[1]]
  from = test_split[[2]]
  parent = parentList[[test_split[[3]]]]
  kontextVal = kontext |> 
    filter(test == test) |> 
    filter(imageID == imageChoose)
  
  cells |>
    colData() |>
    as.data.frame() |>
    filter(imageID == imageChoose) |>
    filter(cellType %in% c(to, from, parent)) |> 
    mutate(cellType = case_when(
      cellType %in% parent[!(parent %in% c(to, from))] ~ "Parent",
      TRUE ~ cellType
    )) |> 
    mutate(cellType = factor(cellType, levels = c(to,  from, "Parent"))) |>
    arrange(desc(cellType)) |>
    ggplot(aes(x = x, y = y, color = cellType)) +
    geom_point(size = 1) +
    scale_colour_manual(values = c( "#404040", "#E25758",  "#D7D8D8")) +
    guides(colour = guide_legend(title = "Cell types", override.aes = list(size = 3))) +
    ggtitle(paste("SpicyR:", round(kontextVal$original, 2), "Kontextual:", round(kontextVal$kontextual, 2)))
}
