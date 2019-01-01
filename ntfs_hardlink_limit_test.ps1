#- Author: Ramprasad Ramshankar 
#- Alias: diyinfosec
#- Date: 01-01-2019
#- Purpose: This is a simple script I wrote to test how many hardlinks I can create for a file. 
#- Language:  Powershell


#- Hypothesis:
#- This started with a question: How many NTFS attributes can a file have?
#- An easy way to add NTFS attributes to a file is by adding hardlinks to it.  
#- When I create a hardlink a $30 ($FILE_NAME) attribute gets added to the file's MFT record. 
#- In the MFT, the Attribute ID field is 2 bytes = 16 bits = 2^16 = 
#- Technically I should be able to create 65536 hardlinks. 

#- Result:
#- For some reason Windows limits the number of hardlinks for a file to 1024 (including the default hardlink when you first create the file)
#- After that I got an error: 
#- "new-Item : An attempt was made to create more links on a file than the file system supports"

#- Additional Reference:
#- This also mentioned in the documentation for CreateHardLinkA function. 
#- "The maximum number of hard links that can be created with this function is 1023 per file. If more than 1023 links are created for a file, an error results."
#- Ref: https://docs.microsoft.com/en-us/windows/desktop/api/winbase/nf-winbase-createhardlinka
#- I am unable to determine why the design decision was made to limit the number of hardlinks :)



#- Iterate over the maximum size of Attribute ID
for($i=1; $i -lt 65536; $i++)
{
	#- This file already exists and I want to create additional hard links for this file.
	$original_file_name="file.txt";

	#- This is the file name for the additional hardlinks for the file
	$new_file_name= "hardlink_" + 	$i.ToString() + "_" + $original_file_name; 
    echo $new_file_name

    #- The new-Item makes it simple to create a hardlink
    new-Item  -ItemType HardLink -Name $new_file_name  -Value $original_file_name;
} 
