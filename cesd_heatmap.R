if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("ComplexHeatmap")

library(ComplexHeatmap)

cesd_combined <- read.csv('C:/Users/diksh/Downloads/combined_astro_19Apr2023_missings_removed.csv')
colnames(cesd_combined) = gsub("rlc", "", colnames(cesd_combined))
colnames(cesd_combined) = gsub("_000", "", colnames(cesd_combined))


#defining binary variables
CESD_category_colors <- list(CESDCategory= c("depressed" = "navy", 
                                             "not_depressed" = "dodgerblue"))


#create annotation object
CESD_row_annotation <- HeatmapAnnotation(df= data.frame(CESDCategory= cesd_combined$xdepressed_140_str), # include the same varaible name from the colors  
                                        col= CESD_category_colors, #Color list we set from above
                                        which = "row")

#creating heatmap
cesd_combined_mat <- cesd_combined[-c(49:96)] #removing unwanted columns from main dataset
cesd_combined_mat <- cesd_combined_mat[-c(1,2,3)] #removing unwanted columns from main dataset

Heatmap(as.matrix(cesd_combined_mat), left_annotation = CESD_row_annotation, cluster_rows=T, show_row_dend=F, 
        row_names_gp = gpar(fontsize= 6), cluster_columns=T, show_column_dend=F,
        column_names_gp = gpar(fontsize= 8), heatmap_legend_param = list(title = "", color_bar = "discrete")) 



