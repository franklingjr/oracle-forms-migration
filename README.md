# oracle-forms-migration

Questions: franklin.goncalves.jr@gmail.com

Oracle PL/SQL scripts and Oracle APEX application developed to transform Oracle Forms business logic into an Oracle PL/SQL database package. For this script there is no mandatory language for your Oracle Forms editor (no need for your Oracle Forms to be installed in english), no minimum Oracle Forms version (no need to upgrade your Oracle Forms to 9i/10g): this script reads Object List Report text files.

Only migrations to Oracle APEX are available at this moment but the script is flexible enough to incorporate other languages upon request.

First, create a separated database user (with privilege to create directory if you wish to batch process your files), and run these scripts in the correct order to create database objects.

Oracle APEX application f102.sql is available for those who prefer processing one file after another - there's a page where you can upload and follow a 5-step process. However, for those who prefer batch processing lots of files, here comes the steps.

- Copy your Oracle Forms object list report text file(s) to your directory, which must be listed in ALL_DIRECTORIES table
- Your text file must be saved in UTF-8 format
- On your MS-DOS command line, execute batch instruction below which will create a text file named "object_list_reports" containing a simple list of your Object List Report text files (this is important because latest SQL file below will read it in order to know which files should be read and processed)

dir /b /ogn *.txt > object_list_reports

Please notice this is what the batch file "object_list_reports.bat" already does.

- Latest file named "migracao_data_batch.sql" should 1) import to your database, 2) read, and 3) process your text files. Don't forget to change the value of "p_directory_name" variable if needed; it's currently set to "SCRIPT" which is "C:\oraclexe\script" directory.

This script covers Oracle Forms from any version that generates an Object List Report text file (menu: File -> Administration -> Object List Report) so there'll be no need to upgrade your old forms to newer Oracle Forms versions.

Your Oracle Forms can be installed in american english, brazilian portuguese and latin american spanish, please contact me if your Oracle Forms is not installed in any of these languages as my script is ready to learn new languages.
