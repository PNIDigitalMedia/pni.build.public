copy and paste the following line into a command prompt with admin permissions: 

powershell -noProfile -executionPolicy bypass -command "mkdir pni-platform; cd pni-platform; wget https://raw.githubusercontent.com/PNIDigitalMedia/pni.build.public/master/setup-environment-bootstrap.bat -outfile setup-environment-bootstrap.bat ; .\setup-environment-bootstrap.bat"