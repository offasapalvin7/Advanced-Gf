$$This tool first checks if Metasploit is installed on the system, and exits if it is not. If Metasploit is installed, it runs the search command with the type:auxiliary argument to list all available auxiliary modules, and parses the output to extract the module names. Finally, it prints the list of available scans.
......



To use this tool, make it executable with 

chmod +x scan_metasploit.sh. 

Then you can run it with ./scan_metasploit.sh.

