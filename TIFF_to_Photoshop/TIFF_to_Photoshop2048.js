//------------------------------------------
// MOVING TIFFS TO PHOTOSHOP TEMPLATE SCRIPT
//------------------------------------------

// Set up:  Put your TIFFs in a folder. Make sure there's no other files in there or other folders
// Make sure your TIFFs are in a sensible order. (eg. sample1_Ch0, sample1_Ch1, sample1_Ch2, sample1_Ch3, sample2_Ch0 etc.)
// The script assumes you have 4 channels per picture, in the order Ch0 Blue (DAPI), Ch1 Green, Ch2 Red, Ch3 Far red.
// The script wont work if you have less than 4 or have Brightfield too
// The Photoshop template is set up for 2048x2048 TIFF images. 

// To run this script, open Adobe Photoshop > File > Scripts > select this script. 
// Photoshop will then run using all the TIFF files in your given input directory. 


// Set your folder of input TIFFs as a variable
// Change directory to where the template is stored on your computer.
var image_folder = Folder("D:/TIFF_to_Photoshop/Input_tiffs/")

// Set your folder you want your combined image outputs as a variable
// Change directory to where the template is stored on your computer.
var output_folder = "D:/TIFF_to_Photoshop/Output_psd/"

// get a list of images from our input folder
var fileList = image_folder.getFiles()

// Define a variable to refer to the Photoshop template which the script will use to put the TIFF images into.
// Change directory to where the template is stored on your computer. 
var fileRefTemplate = File("D:/TIFF_to_Photoshop/microscope_template_empty_2048px.tif")


// Creating a loop that will loop through our list of input files by steps of 4 (for our 4 channels)
for (var i = 0; i < fileList.length; i = i + 4) {
	//open our template and channels of 1 image and assign them as variables to refer to
	var docReftemplate = app.open(fileRefTemplate)
	var docRefch0 = app.open(fileList[i])
	var docRefch1 = app.open(fileList[i+1])
	var docRefch2 = app.open(fileList[i+2])
	var docRefch3 = app.open(fileList[i+3])
	// Move channel 0 (usually DAPI) to template in "blue" layer group
	// select channel 0 document
	app.activeDocument = docRefch0;
	// duplicate the channel0 image and place it in our template
	docRefch0.artLayers[0].duplicate(docReftemplate); 
	// select template
	app.activeDocument = docReftemplate;
	// assign the bottom layer (which is the channel0 layer we just copied) to variable layerRef1
	var layerRef1 = app.activeDocument.layers[0];
	// assign the layer set [2] (blue layer group) to layersetRef2
	var layersetRef2 = app.activeDocument.layerSets[2];
	// move our channel0 layer (layerRef1) to into the blue layer set (layersetRef2)
	layerRef1.move(layersetRef2, ElementPlacement.PLACEATEND); 
	//Repeating previous steps for  all channels
	// Move Channel 1 (green 488) to template in  "green" layer group
	app.activeDocument = docRefch1;
	docRefch1.artLayers[0].duplicate(docReftemplate); 
	app.activeDocument = docReftemplate;
	var layerRef1 = app.activeDocument.layers[0];
	var layersetRef2 = app.activeDocument.layerSets[1];
	layerRef1.move(layersetRef2, ElementPlacement.PLACEATEND); 
	//move channel 2 (red 555) to template in "red" layer group
	app.activeDocument = docRefch2;
	docRefch2.artLayers[0].duplicate(docReftemplate); 
	app.activeDocument = docReftemplate;
	var layerRef1 = app.activeDocument.layers[0];
	var layersetRef2 = app.activeDocument.layerSets[3];
	layerRef1.move(layersetRef2, ElementPlacement.PLACEATEND);
	//move channel 3 (far red) to template in  "white" layer group
	app.activeDocument = docRefch3;
	docRefch3.artLayers[0].duplicate(docReftemplate); 
	app.activeDocument = docReftemplate;
	var layerRef1 = app.activeDocument.layers[0];
	var layersetRef2 = app.activeDocument.layerSets[0];
	layerRef1.move(layersetRef2, ElementPlacement.PLACEATEND); 
	// Saving the finished image
	// converting current image in the list to string
	var filename = fileList[i].toString()
	// take off the .tif extension with slice
	var filename = filename.slice(0,-4)
	// filename contains the whole path, we need to remove that. Splitting based on /
	var pieces = filename.split('/');
	// taking the last element of this list which is only the file name
	var filename = pieces[pieces.length-1];
	//combining the file name with the folder where we want the output and the .psd extension
	var filename = (output_folder + filename + ".psd")
	// initialize a file with filename
	psdFile = new File(filename)
	// save the file
	docReftemplate.saveAs(psdFile)
	//Close Documents
	docReftemplate.close()
	docRefch0.close()
	docRefch1.close()
	docRefch2.close()
	docRefch3.close()
	}




