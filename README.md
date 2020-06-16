# oracle-forms-migration
Oracle PL/SQL scripts and Oracle APEX application, both aimed at migrating from Oracle Forms to other interfaces - only migrations to Oracle APEX are available at this moment; other languages can be covered later.

Oracle APEX application f102.sql is available for those who prefer processing one file after another - there's a page where you can upload and follow a 5-step process. However, for those who prefer batch processing lots of files, here comes the steps.

- Create a separated database user with privilege to create directory
- Upload your Oracle Forms object list report text file to the directory
- Your text file must be UTF-8 format
- Run these scripts in the correct sequence to create database objects
- Execute batch instruction below which will create a text file named "object_list_reports" containing a simple list of your Object List Report text files (this is important because latest SQL file below will read it in order to know which files should be read and processed)

dir /b /ogn *.txt > object_list_reports

The line above contains the contents of batch file "object_list_reports.bat".

- Latest file named "migracao_data_batch.sql" should read and process your text files

This script covers Oracle Forms from any version that generates an Object List Report text file (menu: File -> Administration -> Object List Report) so there'll be no need to upgrade your old forms to newer Oracle Forms versions. Your Oracle Forms can be installed in american english, brazilian portuguese and latin american spanish, please contact me if your Oracle Forms is not installed in any of these languages. It also generates contents for Oracle APEX developers but you can request content creation for other languages.

Questions: franklin.jr@bol.com.br
