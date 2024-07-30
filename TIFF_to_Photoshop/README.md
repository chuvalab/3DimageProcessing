# Transfer of individual grayscale channels .tif files into merged colored photoshop .psd files
Author: Arend W. Overeem

Of note: 
* Put your TIFFs in a folder. Make sure there's no other files in there or other folders
* Make sure your TIFFs are in a sensible order. (eg. sample1_Ch0, sample1_Ch1, sample1_Ch2, sample1_Ch3, sample2_Ch0 etc.)
* The script assumes you have 4 channels per picture, in the order Ch0 Blue (DAPI), Ch1 Green, Ch2 Red, Ch3 Far red.
* The script won’t work if you have less or more than 4 channels
* The Photoshop template is set up for 2048x2048 TIFF images. 

Setting up: 
1.	Make a new folder on your personal drive. Copy microscope_template_empty_2048px.tif to this folder.
    * The script works with TIFFs as long as it is 2048x2048. For different formats, a different template needs to be made.
3.	Make two new folders in this folder, one for input .tif files, and one which will contain output .psd files. An examples is provided in the location of this read_me: “Input_tiffs” & “output_psd” .   “Input_tiffs” contains a test picture (4 channels), you can copy those to your own folder and use them to make sure everything is working properly
4.	Make a copy of “TIFF_to_Photoshop.js”, and move it to one of your folders.  	
5.	You will need to personalize the script (TIFF_to_Photoshop).  We recommend installing a simple editor like: Notepad++ ( https://notepad-plus-plus.org/), and opening it in that.
6.	Open your own copy of “TIFF_to_Photoshop.js” in an editor like notepad++. 
7.	Where it says:  var image_folder =, var output_folder =, and var fileRefTemplate =, change the locations behind those variables to your locations
 	* For example: " D:/TIFF_to_Photoshop/Input_tiffs/"   Changed to  " P:/mydir/ Input_tiffs/"
    * Note: make sure you use / and not \
7.	Move your edited TIFF_to_Photoshop.js to you’re the Script folder of your photoshop install (Default: C:\Program Files\Adobe\Adobe Photoshop 2021\Presets\Scripts)
8.	You’re good to go:
    * Move the TIFFs you want to assemble into photoshop files to your input folder
    * make sure its 4 channel, greyscale and appropriate resolution
    * I generally avoid spaces in file names, and names that are too long.
    * The files should be ordered like: eg. sample1_Ch0, sample1_Ch1, sample1_Ch2, sample1_Ch3, sample2_Ch0 etc.   Format can be Ch00, Ch000, C0, Channel0 as long as the order is consistent.
    * Start with a small number of images to make sure everything works as you want it.
    * To use in Photoshop: File>Scripts>Browse, and select the TIFF_to_Photoshop script. This should start the process and make your images as .psd files in the output file
