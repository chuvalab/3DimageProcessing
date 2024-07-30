# 3DimageProcessing

This repository contains scripts to the manuscript titled ‘Generation of 3D human foetal testis reconstitutions for in vitro culture.’

The repository contains Python scripts and R scripts. 
The Python scripts were used to pipeline microscope image files (.ims or .tif). Inside each script are detailed instructions for use. 

•	The ‘Gray_normTIFF’ script normalizes the signal and grayscales all .tif files from in your specified folder. This is useful for 2D .tif images generated by FIJI. 

•	The ‘Gray_norm_mip_scalebarTIF’ script processes .ims files by separating the channels into 4 .tif files, performs maximum intensity projection (MIP), normalizes the signal and generates a scalebar .tif file from the metadata inside the .ims file. This is useful for (small) 3D .ims images to quickly obtain .tif files and the scalebar for Photoshop. 


The R scripts were used to generate plots from Excel files containing quantification data collected through Imaris. 

•	Each subfolder indicates the Figure in the manuscript for which the script was used. 

•	‘Fig2B’ contains the R file alongside 4 .xls files generated by Imaris (and deleting the first row). The R file plots the data into a violin plot. 

•	‘Fig2CEG’ contains the R file alongside a results data .xls file. The R file plots the absolute DDX4 count, log-normalized DDX4 count and the volumes of reconstitutions with color codes for different parameters inside the .xls file.

•	‘Fig3H’ contains the R file alongside 4 .xls files with results data. The R file plots log-normalized germ cell count per donor into one dot plot, with color codes and shapes for the different parameters in the .xls files. 
