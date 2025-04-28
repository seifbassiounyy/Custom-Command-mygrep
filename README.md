# Custom Command mygrep

## Overview
This bash script is customized version of the grep command. Mainly, it is used to search a given text file for a certain keyword and filter out and print the lines containing this word.
Options to include the index of printed lines and to list the complement of the lines containing the search word are available.

## How to use
To run mygrep.sh script, two main arguments shall be passed within the command. First, the search keyword  argument is passed, then the textfile name as follows.
This command lists the matching lines with this keyword in the testfile.

./mygrep.sh hello testfile.txt

Option arguments can be added to the command
1- ./mygrep.sh -n hello testfile.txt

Lists the matching lines accompanied by their index

2- ./mygrep.sh -v hello testfile.txt

Lists the opposite of the matching lines

3- ./mygrep.sh -v -n hello testfile.txt
   ./mygrep.sh -n -v hello testfile.txt
   ./mygrep.sh -vn hello testfile.txt
   ./mygrep.sh -nv hello testfile.txt

   Lists the opposite of the matching lines accompanied by their index

Also, the script supports a single argument containing the testfile name only without passing the search keyword. It lists nolines since there will not be 
any lines matching an empty string. However, passing -v option lists all lines in the file.

Note: Warning will be displayed to notice that the search keyword is missing. 

./mygrep.sh testfile.txt

./mygrep.sh -v testfile.txt

## Sample run:

![image](https://github.com/user-attachments/assets/e94ebb2b-976e-4a58-978b-27083d1322af)

## Additional Paragraph
If more options to be added, then I would update getopts string to recognize -c -l -i options and add more cases for them while iterating over the options.
Then execute the corresponding command when finding those options as desired. If it is desired to search with a regex instead of a key search word, then I would add a
new option in getopts cases so that I can know that the passed argument is a regex and not a word. Then I would search in the testfile and grep according to that regex and
not considering it as a normal string.




