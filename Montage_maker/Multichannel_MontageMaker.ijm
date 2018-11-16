			name=File.nameWithoutExtension
			output=getDirectory("home")+"Desktop//Montage_Maker//Output//";
			//Template 5D selection
			run("Stack to Image5D", "3rd=ch 4th=z 3rd_dimension_size=4 4th_dimension_size=1 assign");
			rename("current5D");
			//select Template
			run("Open Image5D", "Desktop//Montage_maker//Template//");
			rename("Template");
			selectWindow("current5D");
			run("Transfer Channel Settings", "colormaps labels density_calibrations transfer_settings_from=Template");
			

//----Change channel = #
			run("Set Position", "x-position=1 y-position=1 channel=[1] slice=1 frame=1 display=color");
			//----Change MinMax
			setMinAndMax(0, 30000);
			run("Apply LUT");
			run("Image5D Stack to RGB");
			//change dye
			saveAs("Jpeg", output + name + "_DAPI.jpg");
			//----Change Ch# for saving 
			selectImage("current5D");
			
			//----Change channel = #
			run("Set Position", "x-position=1 y-position=1 channel=[2] slice=1 frame=1 display=color");
			//----Change MinMax
			setMinAndMax(0, 15000);
			run("Apply LUT");
			run("Image5D Stack to RGB");
			//change dye
			saveAs("Jpeg", output + name + "_Lx488.jpg");
			//----Change Ch# for saving 
			selectImage("current5D");

			//----Change channel = #
			run("Set Position", "x-position=1 y-position=1 channel=[3] slice=1 frame=1 display=color");
			//----Change MinMax
			setMinAndMax(0, 50000);
			run("Apply LUT");
			run("Image5D Stack to RGB");
			//change dye
			saveAs("Jpeg", output + name + "_RRX.jpg");
			//----Change Ch# for saving 
			selectImage("current5D");


			//----Change channel = #
			run("Set Position", "x-position=1 y-position=1 channel=[4] slice=1 frame=1 display=color");
			//----Change MinMax
			setMinAndMax(0, 15000);
			run("Apply LUT");
			run("Image5D Stack to RGB");
			//change dye
			saveAs("Jpeg", output + name + "_Atto633.jpg");
			//----Change Ch# for saving
			selectImage("current5D");

			//add more channels if desired, copy/paste, then change channel #
			/*----Change channel = #
			run("Set Position", "x-position=1 y-position=1 channel=[7] slice=1 frame=1 display=color");
			----Change MinMax
			setMinAndMax(0, 12000);
			run("Apply LUT");
			run("Image5D Stack to RGB");
			//change dye
			saveAs("Jpeg", output + name + "_DAPI.jpg");
			---*/


close("current5D");
run("Images to Stack", "name=Stack title=[] use");
Stack.getDimensions(width, height, channels, slices, frames);

//change to desired dimensions
run("Make Montage...", "columns=2 rows=2 scale=1 first=1 last=slices increment=1 border=10 font=12");

//set scale if desired distance(in pixels), known(true measurement; um, mm, etc), pixel(ratio)
run("Set Scale...", "distance=1024 known=212.55 pixel=1 unit=um");
run("Scale Bar...", "width=50 height=12 font=70 color=White background=None location=[Lower Right] bold overlay");
saveAs("Jpeg", output + name + "_Montage.jpg");
close("Stack");